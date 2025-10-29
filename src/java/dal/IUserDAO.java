/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package dal;

import model.User;

/**
 *
 * @author FPT
 */
public interface IUserDAO {
    User getUserByUserEmail(String email) throws Exception;
}
