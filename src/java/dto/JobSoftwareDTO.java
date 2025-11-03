package dto;

public class JobSoftwareDTO {

    private String softwareField;
    private String proficiencyLevel;

    public JobSoftwareDTO() {
    }

    public JobSoftwareDTO(String softwareField, String proficiencyLevel) {
        this.softwareField = softwareField;
        this.proficiencyLevel = proficiencyLevel;
    }

    public String getSoftwareField() {
        return softwareField;
    }

    public void setSoftwareField(String softwareField) {
        this.softwareField = softwareField;
    }

    public String getProficiencyLevel() {
        return proficiencyLevel;
    }

    public void setProficiencyLevel(String proficiencyLevel) {
        this.proficiencyLevel = proficiencyLevel;
    }

}
