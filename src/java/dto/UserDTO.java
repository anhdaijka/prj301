/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.time.LocalDate;
import java.util.UUID;

/**
 *
 * @author FPT
 */
public class UserDTO {
    private UUID id;
    private String email;
    private String name;
    private String phone;
    private LocalDate birthday;
    private String avatarUrl;
    private UUID roleId;
    
    public UserDTO() {}
    
    public UserDTO(UUID id, String email, String name, String phone, 
                   LocalDate birthday, String avatarUrl, UUID roleId) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.phone = phone;
        this.birthday = birthday;
        this.avatarUrl = avatarUrl;
        this.roleId = roleId;
    }
    
    // Getters and Setters
    public UUID getId() {
        return id;
    }
    
    public void setId(UUID id) {
        this.id = id;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public LocalDate getBirthday() {
        return birthday;
    }
    
    public void setBirthday(LocalDate birthday) {
        this.birthday = birthday;
    }
    
    public String getAvatarUrl() {
        return avatarUrl;
    }
    
    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }
    
    public UUID getRoleId() {
        return roleId;
    }
    
    public void setRoleId(UUID roleId) {
        this.roleId = roleId;
    }
}
