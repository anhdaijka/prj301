/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package service;

import model.User;

/**
 *
 * @author FPT
 */
public interface IUserService {
    User login (String email, String password) throws Exception;
}
