/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;

/**
 *
 * @author FPT
 */
public class UserDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    public User login(String email, String password) {
        User user = null;

        try {
            String strSQL = "SELECT * FROM dbo.Users WHERE Email = ? AND [Password] = HASHBYTES('MD5', ?)";
            stm = connection.prepareStatement(strSQL);
            stm.setString(1, email);
            stm.setNString(2, password);
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
}
