/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author FPT
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.OffsetDateTime;
import java.util.UUID;
import java.sql.Types;
import model.User;

public class UserDAO extends DBContext {

    public boolean findUser(String email) {
        String sql = "SELECT 1 FROM dbo.Users WHERE Email = ?";
        if (connection == null) {
            System.out.println("Database connection is null! Check DBContext or properties file.");
            return false;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, email);
            try (ResultSet rs = stm.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException ex) {
            System.out.println("EmailExists SQL Error: " + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
            System.out.println("Unexpected Error: " + ex.getMessage());
            ex.printStackTrace();
        }

        return false;
    }

    public User login(String email, String password) {
        User user = null;
        String sql = "SELECT u.*, r.Name AS Role\n" +
"                  FROM Users u \n" +
"                  JOIN Roles r ON u.roleId = r.id \n" +
"                  WHERE u.Email = ? AND u.Password = ?";

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
                    user.setRole(rs.getString("Role"));
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
        String sql = "INSERT INTO dbo.Users (Id, Email, [Password], [Name], Phone, Birthday, AvatarUrl, RoleId) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        if (connection == null) {
            System.out.println("Database connection is null! Check DBContext or properties file.");
            return false;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            UUID userId = UUID.randomUUID();

            stm.setString(1, userId.toString());
            stm.setString(2, user.getEmail());
            stm.setString(3, user.getPassword());
            stm.setString(4, user.getName());
            stm.setString(5, user.getPhone());
            stm.setString(7, user.getAvatarurl());

            if (user.getRoleId() != null) {
                stm.setString(8, user.getRoleId().toString());
            } else {
                stm.setNull(8, Types.VARCHAR);
            }

            if (user.getBirthday() != null) {
                stm.setDate(6, Date.valueOf(user.getBirthday()));
            } else {
                stm.setNull(6, Types.DATE);
            }

            int rows = stm.executeUpdate();
            return rows > 0;

        } catch (SQLException ex) {
            System.out.println("Register Error: " + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
            System.out.println("Unexpected Error: " + ex.getMessage());
            ex.printStackTrace();
        }
        return false;
    }
}
