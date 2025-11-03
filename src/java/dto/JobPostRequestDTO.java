/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.time.OffsetDateTime;
import java.util.Set;
import java.util.UUID;

public class JobPostRequestDTO {

    private String title;
    private String description;
    private Long salary;
    private OffsetDateTime endDate;
    private String organizationalLevel;
    private String employmentType;
    private boolean displaySalary;
    private Integer minAge;
    private Integer maxAge;
    private String requiredGender;
    private String experienceLevel;
    private boolean acceptsInterns;
    private boolean backgroundCheckRequired;
    private boolean hiringDisabilities;
    private String workingHours;
    private String businessTrips;
    private String country;
    private String city;

    private UUID categoryId;

    private Set<UUID> skillIds;
    private Set<UUID> benefitIds;
    private Set<UUID> studyFieldIds;
    private Set<UUID> educationLevelIds;

    private Set<JobLanguageDTO> languages;
    private Set<JobSoftwareDTO> software;

    public JobPostRequestDTO() {
    }

    public JobPostRequestDTO(String title, String description, Long salary, OffsetDateTime endDate, String organizationalLevel, String employmentType, boolean displaySalary, Integer minAge, Integer maxAge, String requiredGender, String experienceLevel, boolean acceptsInterns, boolean backgroundCheckRequired, boolean hiringDisabilities, String workingHours, String businessTrips, String country, String city, UUID categoryId, Set<UUID> skillIds, Set<UUID> benefitIds, Set<UUID> studyFieldIds, Set<UUID> educationLevelIds, Set<JobLanguageDTO> languages, Set<JobSoftwareDTO> software) {
        this.title = title;
        this.description = description;
        this.salary = salary;
        this.endDate = endDate;
        this.organizationalLevel = organizationalLevel;
        this.employmentType = employmentType;
        this.displaySalary = displaySalary;
        this.minAge = minAge;
        this.maxAge = maxAge;
        this.requiredGender = requiredGender;
        this.experienceLevel = experienceLevel;
        this.acceptsInterns = acceptsInterns;
        this.backgroundCheckRequired = backgroundCheckRequired;
        this.hiringDisabilities = hiringDisabilities;
        this.workingHours = workingHours;
        this.businessTrips = businessTrips;
        this.country = country;
        this.city = city;
        this.categoryId = categoryId;
        this.skillIds = skillIds;
        this.benefitIds = benefitIds;
        this.studyFieldIds = studyFieldIds;
        this.educationLevelIds = educationLevelIds;
        this.languages = languages;
        this.software = software;
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

    public Long getSalary() {
        return salary;
    }

    public void setSalary(Long salary) {
        this.salary = salary;
    }

    public OffsetDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(OffsetDateTime endDate) {
        this.endDate = endDate;
    }

    public String getOrganizationalLevel() {
        return organizationalLevel;
    }

    public void setOrganizationalLevel(String organizationalLevel) {
        this.organizationalLevel = organizationalLevel;
    }

    public String getEmploymentType() {
        return employmentType;
    }

    public void setEmploymentType(String employmentType) {
        this.employmentType = employmentType;
    }

    public boolean isDisplaySalary() {
        return displaySalary;
    }

    public void setDisplaySalary(boolean displaySalary) {
        this.displaySalary = displaySalary;
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

    public String getRequiredGender() {
        return requiredGender;
    }

    public void setRequiredGender(String requiredGender) {
        this.requiredGender = requiredGender;
    }

    public String getExperienceLevel() {
        return experienceLevel;
    }

    public void setExperienceLevel(String experienceLevel) {
        this.experienceLevel = experienceLevel;
    }

    public boolean isAcceptsInterns() {
        return acceptsInterns;
    }

    public void setAcceptsInterns(boolean acceptsInterns) {
        this.acceptsInterns = acceptsInterns;
    }

    public boolean isBackgroundCheckRequired() {
        return backgroundCheckRequired;
    }

    public void setBackgroundCheckRequired(boolean backgroundCheckRequired) {
        this.backgroundCheckRequired = backgroundCheckRequired;
    }

    public boolean isHiringDisabilities() {
        return hiringDisabilities;
    }

    public void setHiringDisabilities(boolean hiringDisabilities) {
        this.hiringDisabilities = hiringDisabilities;
    }

    public String getWorkingHours() {
        return workingHours;
    }

    public void setWorkingHours(String workingHours) {
        this.workingHours = workingHours;
    }

    public String getBusinessTrips() {
        return businessTrips;
    }

    public void setBusinessTrips(String businessTrips) {
        this.businessTrips = businessTrips;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public UUID getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(UUID categoryId) {
        this.categoryId = categoryId;
    }

    public Set<UUID> getSkillIds() {
        return skillIds;
    }

    public void setSkillIds(Set<UUID> skillIds) {
        this.skillIds = skillIds;
    }

    public Set<UUID> getBenefitIds() {
        return benefitIds;
    }

    public void setBenefitIds(Set<UUID> benefitIds) {
        this.benefitIds = benefitIds;
    }

    public Set<UUID> getStudyFieldIds() {
        return studyFieldIds;
    }

    public void setStudyFieldIds(Set<UUID> studyFieldIds) {
        this.studyFieldIds = studyFieldIds;
    }

    public Set<UUID> getEducationLevelIds() {
        return educationLevelIds;
    }

    public void setEducationLevelIds(Set<UUID> educationLevelIds) {
        this.educationLevelIds = educationLevelIds;
    }

    public Set<JobLanguageDTO> getLanguages() {
        return languages;
    }

    public void setLanguages(Set<JobLanguageDTO> languages) {
        this.languages = languages;
    }

    public Set<JobSoftwareDTO> getSoftware() {
        return software;
    }

    public void setSoftware(Set<JobSoftwareDTO> software) {
        this.software = software;
    }

}
