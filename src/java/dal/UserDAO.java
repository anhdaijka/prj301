/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author FPT
 */
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

        if (connection == null) {
            System.out.println("Database connection is null! Check DBContext or properties file.");
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
            System.out.println("Login SQL Error: " + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
            System.out.println("Unexpected Error: " + ex.getMessage());
            ex.printStackTrace();
        }
        return user;
    }
    
    public boolean signUp(User user) {
        String sql = "INSERT INTO dbo.Users (Id, Email, [Password], [Name], Phone, AvatarUrl, RoleId, Birthday, CreatedAt, UpdatedAt) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        if (connection == null) {
            System.out.println("Database connection is null! Check DBContext or properties file.");
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
            System.out.println("Login SQL Error: " + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
            System.out.println("Unexpected Error: " + ex.getMessage());
            ex.printStackTrace();
        }
        return user;
    }
}
