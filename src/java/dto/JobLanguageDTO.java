package dto;
// DTO chứa thông tin cho 1 dòng "Language"

public class JobLanguageDTO {

    private String languageName;
    private String proficiencyLevel;

    public JobLanguageDTO() {
    }

    public JobLanguageDTO(String languageName, String proficiencyLevel) {
        this.languageName = languageName;
        this.proficiencyLevel = proficiencyLevel;
    }

    public String getLanguageName() {
        return languageName;
    }

    public void setLanguageName(String languageName) {
        this.languageName = languageName;
    }

    public String getProficiencyLevel() {
        return proficiencyLevel;
    }

    public void setProficiencyLevel(String proficiencyLevel) {
        this.proficiencyLevel = proficiencyLevel;
    }

}
