/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service.impl;

import dal.IUserDAO;
import dal.impl.UserDAO;
import model.User;
import service.IUserService;

/**
 *
 * @author FPT
 */
public class UserService implements IUserService {

    private final IUserDAO userDAO = new UserDAO();

    @Override
    public User login(String email, String password) throws Exception{
        if (email == null || password == null) {
            return null;
        }
        User user = userDAO.getUserByUserEmail(email);
        if (user == null) {
            return null;
        }

        if (password.equals(user.getPassword())) {
            return user;
        }

        return null;
    }
}
