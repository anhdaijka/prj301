package model;

import java.security.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.UUID;

public class Job {

    private UUID id;
    private String title;
    private String description;
    private int salary;
    private String location;
    private Date endDate;
    private boolean status;
    private UUID userId;
    private UUID companyId;
    private UUID categoryId;

    private String workingHours;
    private Integer minAge;
    private Integer maxAge;
    private String experienceLevel;
    private String degreeRequirement;
    private String genderRequirement;
    private String benefits;
    private String otherRequirements;
    private Timestamp createdAt;

    // Thông tin bổ sung từ JOIN
    private String companyName;
    private String companyLogo;
    private String categoryName;
    private List<String> skills;
    private int daysAgo; // Tính số ngày đã post

    // Constructors
    public Job() {
    }

    public Job(UUID id, String title, String description, int salary, String location, Date endDate, boolean status, UUID userId, UUID companyId, UUID categoryId, String workingHours, Integer minAge, Integer maxAge, String experienceLevel, String degreeRequirement, String genderRequirement, String benefits, String otherRequirements, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.salary = salary;
        this.location = location;
        this.endDate = endDate;
        this.status = status;
        this.userId = userId;
        this.companyId = companyId;
        this.categoryId = categoryId;
        this.workingHours = workingHours;
        this.minAge = minAge;
        this.maxAge = maxAge;
        this.experienceLevel = experienceLevel;
        this.degreeRequirement = degreeRequirement;
        this.genderRequirement = genderRequirement;
        this.benefits = benefits;
        this.otherRequirements = otherRequirements;
        this.createdAt = createdAt;
    }

    // Getters & Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public UUID getCompanyId() {
        return companyId;
    }

    public void setCompanyId(UUID companyId) {
        this.companyId = companyId;
    }

    public UUID getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(UUID categoryId) {
        this.categoryId = categoryId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyLogo() {
        return companyLogo;
    }

    public void setCompanyLogo(String companyLogo) {
        this.companyLogo = companyLogo;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<String> getSkills() {
        return skills;
    }

    public void setSkills(List<String> skills) {
        this.skills = skills;
    }

    public int getDaysAgo() {
        return daysAgo;
    }

    public void setDaysAgo(int daysAgo) {
        this.daysAgo = daysAgo;
    }

    public String getWorkingHours() {
        return workingHours;
    }

    public void setWorkingHours(String workingHours) {
        this.workingHours = workingHours;
    }

    public Integer getMinAge() {
        return minAge;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public String getExperienceLevel() {
        return experienceLevel;
    }

    public void setExperienceLevel(String experienceLevel) {
        this.experienceLevel = experienceLevel;
    }

    public String getDegreeRequirement() {
        return degreeRequirement;
    }

    public void setDegreeRequirement(String degreeRequirement) {
        this.degreeRequirement = degreeRequirement;
    }

    public String getGenderRequirement() {
        return genderRequirement;
    }

    public void setGenderRequirement(String genderRequirement) {
        this.genderRequirement = genderRequirement;
    }

    public String getBenefits() {
        return benefits;
    }

    public void setBenefits(String benefits) {
        this.benefits = benefits;
    }

    public String getOtherRequirements() {
        return otherRequirements;
    }

    public void setOtherRequirements(String otherRequirements) {
        this.otherRequirements = otherRequirements;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

}
