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
import model.Job;

public class JobDAO extends DBContext {
    
    public List<Job> getNewestJobs(int limit) {
        List<Job> jobs = new ArrayList<>();
        String sql = """
            SELECT TOP (?) 
                            j.Id, j.Title, j.Description, j.Salary, j.Location, 
                            j.EndDate, j.Status, j.CompanyId, j.CategoryId,
                            c.Name AS CompanyName, c.ImageUrl AS CompanyLogo,
                            cat.Name AS CategoryName,
                            DATEDIFF(DAY, j.EndDate, GETDATE()) AS DaysAgo
                        FROM Jobs j
                        LEFT JOIN Companies c ON j.CompanyId = c.Id
                        LEFT JOIN Categories cat ON j.CategoryId = cat.Id
                        WHERE j.Status = 'True'
                        ORDER BY j.EndDate DESC
        """;
        
        if (connection == null) {
            System.err.println("ERROR: Database connection is NULL!");
            return jobs;
        }
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, limit);
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Job job = extractJobFromResultSet(rs);
                    
                    // Load skills cho job này
                    job.setSkills(getJobSkills(job.getId()));
                    
                    jobs.add(job);
                }
            }
            
            System.out.println("Loaded " + jobs.size() + " newest jobs");
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getNewestJobs: " + ex.getMessage());
            ex.printStackTrace();
        }
        
        return jobs;
    }
    
    public List<Job> getAllJobs(int page, int pageSize) {
        List<Job> jobs = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        
        String sql = """
            SELECT 
                j.Id, j.Title, j.Description, j.Salary, j.Location, 
                j.EndDate, j.Status, j.CompanyId, j.CategoryId,
                c.Name AS CompanyName, c.Logo AS CompanyLogo,
                cat.Name AS CategoryName,
                DATEDIFF(DAY, j.EndDate, GETDATE()) AS DaysAgo
            FROM Jobs j
            LEFT JOIN Companies c ON j.CompanyId = c.Id
            LEFT JOIN Categories cat ON j.CategoryId = cat.Id
            WHERE j.Status = 'Active'
            ORDER BY j.EndDate DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, offset);
            stm.setInt(2, pageSize);
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Job job = extractJobFromResultSet(rs);
                    job.setSkills(getJobSkills(job.getId()));
                    jobs.add(job);
                }
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getAllJobs: " + ex.getMessage());
            ex.printStackTrace();
        }
        
        return jobs;
    }
    
    public Job getJobById(UUID jobId) {
        String sql = """
            SELECT 
                j.Id, j.Title, j.Description, j.Salary, j.Location, 
                j.EndDate, j.Status, j.CompanyId, j.CategoryId, j.UserId,
                c.Name AS CompanyName, c.Logo AS CompanyLogo,
                cat.Name AS CategoryName,
                DATEDIFF(DAY, j.EndDate, GETDATE()) AS DaysAgo
            FROM Jobs j
            LEFT JOIN Companies c ON j.CompanyId = c.Id
            LEFT JOIN Categories cat ON j.CategoryId = cat.Id
            WHERE j.Id = ?
        """;
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, jobId.toString());
            
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    Job job = extractJobFromResultSet(rs);
                    job.setSkills(getJobSkills(job.getId()));
                    return job;
                }
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getJobById: " + ex.getMessage());
            ex.printStackTrace();
        }
        
        return null;
    }
    
    public List<Job> getJobsByCategory(UUID categoryId) {
        List<Job> jobs = new ArrayList<>();
        String sql = """
            SELECT 
                j.Id, j.Title, j.Description, j.Salary, j.Location, 
                j.EndDate, j.Status, j.CompanyId, j.CategoryId,
                c.Name AS CompanyName, c.Logo AS CompanyLogo,
                cat.Name AS CategoryName,
                DATEDIFF(DAY, j.EndDate, GETDATE()) AS DaysAgo
            FROM Jobs j
            LEFT JOIN Companies c ON j.CompanyId = c.Id
            LEFT JOIN Categories cat ON j.CategoryId = cat.Id
            WHERE j.CategoryId = ? AND j.Status = 'Active'
            ORDER BY j.EndDate DESC
        """;
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, categoryId.toString());
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Job job = extractJobFromResultSet(rs);
                    job.setSkills(getJobSkills(job.getId()));
                    jobs.add(job);
                }
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getJobsByCategory: " + ex.getMessage());
            ex.printStackTrace();
        }
        
        return jobs;
    }
    
    private List<String> getJobSkills(UUID jobId) {
        List<String> skills = new ArrayList<>();
        String sql = """
            SELECT s.Name
            FROM JobSkills js
            INNER JOIN Skills s ON js.SkillId = s.Id
            WHERE js.JobId = ?
        """;
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, jobId.toString());
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    skills.add(rs.getString("Name"));
                }
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getJobSkills: " + ex.getMessage());
        }
        
        return skills;
    }
    
    public int getTotalJobs() {
        String sql = "SELECT COUNT(*) FROM Jobs WHERE Status = 'Active'";
        
        try (PreparedStatement stm = connection.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in getTotalJobs: " + ex.getMessage());
        }
        
        return 0;
    }
    
    public List<Job> searchJobs(String keyword) {
        List<Job> jobs = new ArrayList<>();
        String sql = """
            SELECT 
                j.Id, j.Title, j.Description, j.Salary, j.Location, 
                j.EndDate, j.Status, j.CompanyId, j.CategoryId,
                c.Name AS CompanyName, c.Logo AS CompanyLogo,
                cat.Name AS CategoryName,
                DATEDIFF(DAY, j.EndDate, GETDATE()) AS DaysAgo
            FROM Jobs j
            LEFT JOIN Companies c ON j.CompanyId = c.Id
            LEFT JOIN Categories cat ON j.CategoryId = cat.Id
            WHERE j.Status = 'Active' 
                AND (j.Title LIKE ? OR j.Description LIKE ? OR c.Name LIKE ?)
            ORDER BY j.EndDate DESC
        """;
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stm.setString(1, searchPattern);
            stm.setString(2, searchPattern);
            stm.setString(3, searchPattern);
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Job job = extractJobFromResultSet(rs);
                    job.setSkills(getJobSkills(job.getId()));
                    jobs.add(job);
                }
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in searchJobs: " + ex.getMessage());
            ex.printStackTrace();
        }
        
        return jobs;
    }
    
    private Job extractJobFromResultSet(ResultSet rs) throws SQLException {
        Job job = new Job();
        job.setId(UUID.fromString(rs.getString("Id")));
        job.setTitle(rs.getString("Title"));
        job.setDescription(rs.getString("Description"));
        job.setSalary(rs.getInt("Salary"));
        job.setLocation(rs.getString("Location"));
        job.setEndDate(rs.getDate("EndDate"));
        job.setStatus(rs.getString("Status"));
        job.setCompanyId(rs.getString("CompanyId") != null ? 
            UUID.fromString(rs.getString("CompanyId")) : null);
        job.setCategoryId(rs.getString("CategoryId") != null ? 
            UUID.fromString(rs.getString("CategoryId")) : null);
        
        // Thông tin bổ sung
        job.setCompanyName(rs.getString("CompanyName"));
        job.setCompanyLogo(rs.getString("CompanyLogo"));
        job.setCategoryName(rs.getString("CategoryName"));
        job.setDaysAgo(rs.getInt("DaysAgo"));
        
        return job;
    }
}
