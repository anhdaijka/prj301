package model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.UUID;

public class Job {

    private int id;
    private String title;
    private int categoryId;
    private String salary;
    private String location;
    private Date endDate;
    private String workingHours;
    private Integer minAge;
    private Integer maxAge;
    private String experienceLevel;
    private String degreeRequirement;
    private String genderRequirement;
    private String description;
    private String benefits;
    private String otherRequirements;
    private Timestamp createdAt;
    private UUID userId;
    private String status;

    // Constructors
    public Job() {
    }

    public Job(int id, String title, int categoryId, String salary, String location, Date endDate, String workingHours, Integer minAge, Integer maxAge, String experienceLevel, String degreeRequirement, String genderRequirement, String description, String benefits, String otherRequirements, Timestamp createdAt, UUID userId, String status) {
        this.id = id;
        this.title = title;
        this.categoryId = categoryId;
        this.salary = salary;
        this.location = location;
        this.endDate = endDate;
        this.workingHours = workingHours;
        this.minAge = minAge;
        this.maxAge = maxAge;
        this.experienceLevel = experienceLevel;
        this.degreeRequirement = degreeRequirement;
        this.genderRequirement = genderRequirement;
        this.description = description;
        this.benefits = benefits;
        this.otherRequirements = otherRequirements;
        this.createdAt = createdAt;
        this.userId = userId;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
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

}
