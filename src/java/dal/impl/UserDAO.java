/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.impl;

import dal.DBContext;
import dal.IUserDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;
import model.User;

/**
 *
 * @author FPT
 */
public class UserDAO extends DBContext implements IUserDAO {

    PreparedStatement stm;
    ResultSet rs;

    @Override
    public User getUserByUserEmail(String email) throws Exception {

        User user = new User();
        try {
            String sql = "SELECT * FROM Users WHERE Email = ?";
            stm = connection.prepareCall(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                user.setId(UUID.fromString(rs.getString("Id")));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setName(rs.getString("Name"));
                user.setPhone(rs.getString("Phone"));
                user.setBirthday(rs.getDate("Birthday").toLocalDate());
                user.setAvatarurl(rs.getString("AvatarUrl"));
                user.setRoleId(UUID.fromString(rs.getString("RoleId")));
            }
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
        }
        return user;
    }

}
