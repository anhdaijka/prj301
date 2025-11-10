package model;

import java.util.UUID;

public class Category {

    private UUID id;
    private String name;
    private int jobCount;

    public Category() {
    }

    public Category(UUID id, String name, int jobCount) {
        this.id = id;
        this.name = name;
        this.jobCount = jobCount;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getJobCount() {
        return jobCount;
    }

    public void setJobCount(int jobCount) {
        this.jobCount = jobCount;

    }
}
