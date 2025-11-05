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
        String sql = "SELECT u.*, r.Name AS Role\n"
                + "                  FROM Users u \n"
                + "                  JOIN Roles r ON u.roleId = r.id \n"
                + "                  WHERE u.Email = ? AND u.Password = ?";

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
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPassword(rs.getString("Password"));
                    user.setLocation(rs.getString("Location"));
                    user.setPostalCode(rs.getString("PostalCode"));
                    user.setMinimumSalary(rs.getInt("MinimumSalary"));
                    Object minSalObj = rs.getObject("MinimumSalary");
                    if (minSalObj != null) {
                        user.setMinimumSalary(rs.getInt("MinimumSalary"));
                    } else {
                        user.setMinimumSalary(null);
                    }
                    user.setPaymentPeriod(rs.getString("PaymentPeriod"));
                    user.setResumeUrl(rs.getString("ResumeUrl"));
                    user.setAvatarUrl(rs.getString("AvatarUrl"));
                    user.setPhone(rs.getString("Phone"));
                    java.sql.Date birthday = rs.getDate("Birthday");
                    if (birthday != null) {
                        user.setBirthday(birthday.toLocalDate());
                    }
                    String roleIdStr = rs.getString("RoleId");
                    if (roleIdStr != null) {
                        user.setRoleId(UUID.fromString(roleIdStr));
                    }
                    user.setRoleName(rs.getString("Role"));
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
        String sql = "INSERT INTO dbo.Users ("
                + "Id, FullName, Email, [Password], Location, PostalCode, MinimumSalary, "
                + "PaymentPeriod, ResumeUrl, RoleId) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        if (connection == null) {
            System.out.println("Database connection is null! Check DBContext or properties file.");
            return false;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            UUID userId = UUID.randomUUID();

            stm.setString(1, userId.toString());
            stm.setString(2, user.getFullName());
            stm.setString(3, user.getEmail());
            stm.setString(4, user.getPassword());
            stm.setString(5, user.getLocation());
            stm.setString(6, user.getPostalCode());

            // MinimumSalary (có thể null)
            if (user.getMinimumSalary() != null) {
                stm.setInt(7, user.getMinimumSalary());
            } else {
                stm.setNull(7, Types.INTEGER);
            }

            stm.setString(8, user.getPaymentPeriod());
            stm.setString(9, user.getResumeUrl());

            if (user.getRoleId() != null) {
                stm.setString(10, user.getRoleId().toString());
            } else {
                stm.setString(10, "e90cc62e-8cbc-4776-8601-c0c604367776");
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
