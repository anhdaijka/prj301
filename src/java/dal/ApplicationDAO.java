/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Application;

/**
 *
 * @author FPT (Adapted by Gemini)
 */
public class ApplicationDAO extends DBContext {

    public boolean hasUserApplied(String userId, String jobId) {
        String sql = "SELECT 1 FROM dbo.Applications WHERE UserId = ? AND JobId = ?";

        if (connection == null) {
            System.out.println("Database connection is null! Check DBContext.");
            return false;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, userId);
            stm.setString(2, jobId);

            try (ResultSet rs = stm.executeQuery()) {
                // Nếu rs.next() trả về true, nghĩa là tìm thấy 1 bản ghi
                return rs.next();
            }
        } catch (SQLException ex) {
            System.out.println("hasUserApplied SQL Error: " + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
            System.out.println("Unexpected Error: " + ex.getMessage());
            ex.printStackTrace();
        }

        return false;
    }

    public boolean createApplication(Application app) {
        String sql = "INSERT INTO dbo.Applications (Id, UserId, JobId, Status, Note, CvSnapshot, AppliedAt) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        if (connection == null) {
            System.out.println("Database connection is null! Check DBContext.");
            return false;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {

            // Set các tham số
            stm.setString(1, app.getId());       // Id (uniqueidentifier)
            stm.setString(2, app.getUserId());   // UserId (uniqueidentifier)
            stm.setString(3, app.getJobId());    // JobId (uniqueidentifier)
            stm.setString(4, app.getStatus());   // Status (nvarchar)
            stm.setString(5, app.getNote());     // Note (nvarchar)
            stm.setString(6, app.getCvSnapshot()); // CvSnapshot (nvarchar)

            stm.setTimestamp(7, new Timestamp(app.getAppliedAt().getTime()));

            int rowsAffected = stm.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException ex) {
            System.out.println("createApplication SQL Error: " + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
            System.out.println("Unexpected Error: " + ex.getMessage());
            ex.printStackTrace();
        }

        return false;
    }

    public List<Application> getApplicationsByUserId(String userId) {
        List<Application> applications = new ArrayList<>();

        String sql = """
        SELECT 
            a.Id, a.UserId, a.JobId, a.Status, a.Note, a.CvSnapshot, a.AppliedAt,
            j.Title AS JobTitle,
            j.Location AS JobLocation, 
            c.Name AS CompanyName,
            c.ImageUrl AS CompanyLogo, 
            (SELECT STRING_AGG(s.Name, ', ') 
             FROM JobSkills js JOIN Skills s ON js.SkillId = s.Id 
             WHERE js.JobId = j.Id) AS JobSkills 
        FROM 
            dbo.Applications a
        LEFT JOIN 
            dbo.Jobs j ON a.JobId = j.Id
        LEFT JOIN 
            dbo.Companies c ON j.CompanyId = c.Id
        WHERE 
            a.UserId = ?
        ORDER BY 
            a.AppliedAt DESC
    """;

        if (connection == null) {
            System.out.println("Database connection is null! Check DBContext.");
            return applications;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, userId);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Application app = new Application();

                    app.setId(rs.getString("Id"));
                    app.setUserId(rs.getString("UserId"));
                    app.setJobId(rs.getString("JobId"));
                    app.setStatus(rs.getString("Status"));
                    app.setNote(rs.getString("Note"));
                    app.setCvSnapshot(rs.getString("CvSnapshot"));
                    app.setAppliedAt(rs.getTimestamp("AppliedAt"));

                    app.setJobTitle(rs.getString("JobTitle"));
                    app.setCompanyName(rs.getString("CompanyName"));
                    app.setCompanyLogo(rs.getString("CompanyLogo"));

                    // SỬA LẠI: Thêm 2 dòng set mới
                    app.setJobLocation(rs.getString("JobLocation"));
                    app.setJobSkills(rs.getString("JobSkills"));

                    applications.add(app);
                }
            }
        } catch (SQLException ex) {
            // Lỗi SQL (ví dụ: cột 'c.ImageUrl' không tồn tại) SẼ GÂY RA TRANG TRẮNG
            System.out.println("getApplicationsByUserId SQL Error: " + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
            System.out.println("Unexpected Error in getApplicationsByUserId: " + ex.getMessage());
            ex.printStackTrace();
        }

        return applications;
    }
}
