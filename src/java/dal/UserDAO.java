/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;*/

/**
 *
 * @author FPT
 */
/*public class UserDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    public User login(String email, String password) {
        User user = null;

        try {
            String strSQL = "SELECT * FROM dbo.Users WHERE Email = ? AND [Password] = ?";
            stm = connection.prepareStatement(strSQL);
            stm.setString(1, email);
            stm.setString(2, password);
            rs = stm.executeQuery();

            while (rs.next()) {
                user = new User();

                user.setId(java.util.UUID.fromString(rs.getString("Id")));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setName(rs.getString("Name"));
                user.setPhone(rs.getString("Phone"));
                user.setAvatarurl(rs.getString("AvatarUrl"));
                user.setRoleId(java.util.UUID.fromString(rs.getString("Id")));
                user.setBirthday(rs.getDate("Birthday").toLocalDate());
                user.setCreatedAt(rs.getObject("CreatedAt", java.time.OffsetDateTime.class));
                user.setUpdatedAt(rs.getObject("UpdatedAt", java.time.OffsetDateTime.class));
            }
        } catch (Exception ex) {
            System.out.println("GetAccountByEmail: " + ex.getMessage());
            ex.printStackTrace(); // In chi tiết lỗi ra console để dễ gỡ rối
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (Exception e) {
                System.out.println("Resource: " + e.getMessage());
            }
        }
        return user;
    }
}*/

package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.OffsetDateTime;
import java.util.UUID;
import model.User;

public class UserDAO extends DBContext {

    public User login(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM dbo.Users WHERE Email = ? AND [Password] = ?";

        // ✅ Kiểm tra kết nối trước khi thực thi
        if (connection == null) {
            System.out.println("❌ Database connection is null! Check DBContext or properties file.");
            return null;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, email);
            stm.setString(2, password);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    user = new User();

                    user.setId(UUID.fromString(rs.getString("Id")));
                    user.setEmail(rs.getString("Email"));
                    user.setPassword(rs.getString("Password"));
                    user.setName(rs.getString("Name"));
                    user.setPhone(rs.getString("Phone"));
                    user.setAvatarurl(rs.getString("AvatarUrl"));

                    // ✅ lấy đúng RoleId (sửa lỗi copy nhầm Id)
                    String roleIdStr = rs.getString("RoleId");
                    if (roleIdStr != null) {
                        user.setRoleId(UUID.fromString(roleIdStr));
                    }

                    java.sql.Date birthday = rs.getDate("Birthday");
                    if (birthday != null) {
                        user.setBirthday(birthday.toLocalDate());
                    }

                    OffsetDateTime createdAt = rs.getObject("CreatedAt", OffsetDateTime.class);
                    if (createdAt != null) {
                        user.setCreatedAt(createdAt);
                    }

                    OffsetDateTime updatedAt = rs.getObject("UpdatedAt", OffsetDateTime.class);
                    if (updatedAt != null) {
                        user.setUpdatedAt(updatedAt);
                    }
                }
            }
        } catch (SQLException ex) {
            System.out.println("❌ Login SQL Error: " + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
            System.out.println("❌ Unexpected Error: " + ex.getMessage());
            ex.printStackTrace();
        }

        return user;
    }
}
