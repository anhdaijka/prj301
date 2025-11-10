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
    
    /**
     * Lấy danh sách các công ty hàng đầu (có nhiều việc làm nhất).
     */
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
                    company.setSkills(getCompanySkills(company.getId())); // Tải skills
                    company.setRating(4.0 + Math.random()); // Rating giả
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
            GROUP BY c.Id, c.Name, c.Description, c.Location, c.Website, c.ImageUrl
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

    /**
     * HÀM MỚI: Tìm kiếm công ty theo keyword (tên hoặc mô tả).
     */
    public List<Company> searchCompanies(String keyword) {
        List<Company> companies = new ArrayList<>();
        String searchKeyword = "%" + keyword + "%";
        
        String sql = """
            SELECT 
                c.Id, c.Name, c.Description, c.Location, c.Website, c.ImageUrl,
                COUNT(j.Id) AS JobCount,
                AVG(CAST(j.Salary AS FLOAT)) AS AvgSalary
            FROM Companies c
            LEFT JOIN Jobs j ON c.Id = j.CompanyId
            WHERE c.Name LIKE ? OR c.Description LIKE ?
            GROUP BY c.Id, c.Name, c.Description, c.Location, c.Website, c.ImageUrl
            ORDER BY JobCount DESC, c.Name
        """;
        
        if (connection == null) {
            System.err.println("ERROR: Database connection is NULL!");
            return companies;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, searchKeyword);
            stm.setString(2, searchKeyword);
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Company company = extractCompanyFromResultSet(rs);
                    company.setSkills(getCompanySkills(company.getId()));
                    company.setRating(4.0 + Math.random());
                    companies.add(company);
                }
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in searchCompanies: " + ex.getMessage());
            ex.printStackTrace();
        }
        
        return companies;
    }
  
    public Company getCompanyById(UUID companyId) {
        String sql = """
            SELECT 
                c.Id, c.Name, c.Description, c.Location, c.Website, c.ImageUrl,
                COUNT(j.Id) AS JobCount,
                AVG(CAST(j.Salary AS FLOAT)) AS AvgSalary
            FROM Companies c
            LEFT JOIN Jobs j ON c.Id = j.CompanyId
            WHERE c.Id = ?
            GROUP BY c.Id, c.Name, c.Description, c.Location, c.Website, c.ImageUrl
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
    
    /**
     * Lấy 2 skills hàng đầu liên quan đến các công việc của công ty.
     */
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
    
    /**
     * Lấy tổng số công ty.
     */
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
    
    /**
     * Hàm private để trích xuất dữ liệu từ ResultSet thành đối tượng Company.
     */
    private Company extractCompanyFromResultSet(ResultSet rs) throws SQLException {
        Company company = new Company();
        company.setId(UUID.fromString(rs.getString("Id")));
        company.setName(rs.getString("Name"));
        company.setDescription(rs.getString("Description"));
        company.setLocation(rs.getString("Location"));
        company.setWebsite(rs.getString("Website"));
        
        // Ánh xạ cột 'ImageUrl' vào trường 'logo' của model
        company.setLogo(rs.getString("ImageUrl")); 
        
        company.setJobCount(rs.getInt("JobCount"));
        
        double avgSalary = rs.getDouble("AvgSalary");
        company.setAvgSalary(rs.wasNull() ? 0 : avgSalary);
        
        // Dữ liệu giả
        company.setReviewCount((int)(Math.random() * 100 + 50)); 
        
        return company;
    }
}