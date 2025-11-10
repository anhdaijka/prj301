package model;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

/**
 *
 * @author FPT
 */
public class User {
    private UUID id;
    private String fullName;
    private String email;
    private String password;
    private String location;
    private String postalCode;
    private Integer minimumSalary;
    private String paymentPeriod;
    private String resumeUrl;
    private String avatarUrl;
    private String phone;
    private LocalDate birthday;
    private UUID roleId;
    private String roleName; // để JOIN bảng Roles lấy tên quyền nếu cần

    // --- Constructors ---
    public User() {
    }

    public User(UUID id, String fullName, String email, String password, String location, 
                String postalCode, Integer minimumSalary, String paymentPeriod,
                String resumeUrl, String avatarUrl, String phone, LocalDate birthday, UUID roleId) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.location = location;
        this.postalCode = postalCode;
        this.minimumSalary = minimumSalary;
        this.paymentPeriod = paymentPeriod;
        this.resumeUrl = resumeUrl;
        this.avatarUrl = avatarUrl;
        this.phone = phone;
        this.birthday = birthday;
        this.roleId = roleId;
    }

    // --- Getters and Setters ---
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public Integer getMinimumSalary() {
        return minimumSalary;
    }

    public void setMinimumSalary(Integer minimumSalary) {
        this.minimumSalary = minimumSalary;
    }

    public String getPaymentPeriod() {
        return paymentPeriod;
    }

    public void setPaymentPeriod(String paymentPeriod) {
        this.paymentPeriod = paymentPeriod;
    }

    public String getResumeUrl() {
        return resumeUrl;
    }

    public void setResumeUrl(String resumeUrl) {
        this.resumeUrl = resumeUrl;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
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

    public UUID getRoleId() {
        return roleId;
    }

    public void setRoleId(UUID roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
