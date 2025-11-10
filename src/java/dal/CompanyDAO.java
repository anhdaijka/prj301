/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Company;

public class CompanyDAO extends DBContext {
    
    public List<Company> getTopCompanies(int limit) {
        List<Company> companies = new ArrayList<>();
        String sql = """
            SELECT TOP (?) 
                            c.Id, c.Name, c.Description, c.Location, c.Website, c.ImageUrl,
                            COUNT(j.Id) AS JobCount,
                            AVG(CAST(j.Salary AS FLOAT)) AS AvgSalary
                        FROM Companies c
                        LEFT JOIN Jobs j ON c.Id = j.CompanyId AND j.Status = 'True'
                        GROUP BY c.Id, c.Name, c.Description, c.Location, c.Website, c.ImageUrl
                        HAVING COUNT(j.Id) > 0
                        ORDER BY JobCount DESC, c.Name
        """;
        
        if (connection == null) {
            System.err.println("ERROR: Database connection is NULL!");
            return companies;
        }
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, limit);
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Company company = extractCompanyFromResultSet(rs);
                    
                    // Load skills cho company này
                    company.setSkills(getCompanySkills(company.getId()));
                    
                    // Set rating giả (có thể lấy từ bảng Reviews nếu có)
                    company.setRating(4.0 + Math.random()); // Random 4.0-5.0
                    
                    companies.add(company);
                }
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getTopCompanies: " + ex.getMessage());
            ex.printStackTrace();
        }
        
        return companies;
    }
    
    public List<Company> getAllCompanies(int page, int pageSize) {
        List<Company> companies = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        
        String sql = """
            SELECT 
                c.Id, c.Name, c.Description, c.Location, c.Website, c.ImageUrl,
                COUNT(j.Id) AS JobCount,
                AVG(CAST(j.Salary AS FLOAT)) AS AvgSalary
            FROM Companies c
            LEFT JOIN Jobs j ON c.Id = j.CompanyId
            GROUP BY c.Id, c.Name, c.Description, c.Location, c.Website, c.Logo
            ORDER BY c.Name
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, offset);
            stm.setInt(2, pageSize);
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Company company = extractCompanyFromResultSet(rs);
                    company.setSkills(getCompanySkills(company.getId()));
                    company.setRating(4.0 + Math.random());
                    companies.add(company);
                }
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getAllCompanies: " + ex.getMessage());
            ex.printStackTrace();
        }
        
        return companies;
    }
    
    public Company getCompanyById(UUID companyId) {
        String sql = """
            SELECT 
                c.Id, c.Name, c.Description, c.Location, c.Website, c.Logo,
                COUNT(j.Id) AS JobCount,
                AVG(CAST(j.Salary AS FLOAT)) AS AvgSalary
            FROM Companies c
            LEFT JOIN Jobs j ON c.Id = j.CompanyId
            WHERE c.Id = ?
            GROUP BY c.Id, c.Name, c.Description, c.Location, c.Website, c.Logo
        """;
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, companyId.toString());
            
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    Company company = extractCompanyFromResultSet(rs);
                    company.setSkills(getCompanySkills(company.getId()));
                    company.setRating(4.0 + Math.random());
                    return company;
                }
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getCompanyById: " + ex.getMessage());
            ex.printStackTrace();
        }
        
        return null;
    }
    
    private List<String> getCompanySkills(UUID companyId) {
        List<String> skills = new ArrayList<>();
        String sql = """
            SELECT TOP 2 s.Name, COUNT(*) AS SkillCount
            FROM Jobs j
            INNER JOIN JobSkills js ON j.Id = js.JobId
            INNER JOIN Skills s ON js.SkillId = s.Id
            WHERE j.CompanyId = ?
            GROUP BY s.Name
            ORDER BY SkillCount DESC
        """;
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, companyId.toString());
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    skills.add(rs.getString("Name"));
                }
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getCompanySkills: " + ex.getMessage());
        }
        
        return skills;
    }
    
    public int getTotalCompanies() {
        String sql = "SELECT COUNT(*) FROM Companies";
        
        try (PreparedStatement stm = connection.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getTotalCompanies: " + ex.getMessage());
        }
        
        return 0;
    }
    
    private Company extractCompanyFromResultSet(ResultSet rs) throws SQLException {
        Company company = new Company();
        company.setId(UUID.fromString(rs.getString("Id")));
        company.setName(rs.getString("Name"));
        company.setDescription(rs.getString("Description"));
        company.setLocation(rs.getString("Location"));
        company.setWebsite(rs.getString("Website"));
        company.setLogo(rs.getString("ImageUrl"));
        company.setJobCount(rs.getInt("JobCount"));
        
        // AvgSalary có thể null nếu không có jobs
        double avgSalary = rs.getDouble("AvgSalary");
        company.setAvgSalary(rs.wasNull() ? 0 : avgSalary);
        
        // Set review count giả (có thể lấy từ DB nếu có bảng Reviews)
        company.setReviewCount((int)(Math.random() * 100 + 50)); // 50-150
        
        return company;
    }
}
