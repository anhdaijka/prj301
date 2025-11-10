/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import model.Application;

/**
 *
 * @author FPT (Adapted by Gemini)
 */
public class ApplicationDAO extends DBContext {

    public boolean hasUserApplied(String userId, String jobId) {
        // Dùng SELECT 1 để kiểm tra sự tồn tại, tương tự như findUser
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
            
            // Chuyển đổi java.util.Date sang java.sql.Timestamp cho cột 'datetime'
            stm.setTimestamp(7, new Timestamp(app.getAppliedAt().getTime())); 

            int rowsAffected = stm.executeUpdate();
            
            // Trả về true nếu có 1 hàng bị ảnh hưởng (insert thành công)
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
}