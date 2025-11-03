package model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.UUID;

public class Job {

    private int id;
    private String title;
    private String description;
    private String salary;
    private String location;
    private Date endDate;
    private String status;
    private UUID userId;
    private Integer categoryId;
    private Timestamp createdAt;
    private String workingHours;
    private Integer minAge;
    private Integer maxAge;

    // Constructors
    public Job() {
    }

    public Job(int id, String title, String description, String salary, String location,
            Date endDate, String status, UUID userId, Integer categoryId, Timestamp createdAt,
            String workingHours, Integer minAge, Integer maxAge) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.salary = salary;
        this.location = location;
        this.endDate = endDate;
        this.status = status;
        this.userId = userId;
        this.categoryId = categoryId;
        this.createdAt = createdAt;
        this.workingHours = workingHours;
        this.minAge = minAge;
        this.maxAge = maxAge;
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

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
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
}
