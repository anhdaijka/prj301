package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Skill;

public class SkillDAO extends DBContext {

    public List<Skill> getAllSkills() {
        List<Skill> skills = new ArrayList<>();

        String sql = "SELECT * FROM Skills ORDER BY Name";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                Skill skill = new Skill();

                skill.setId(UUID.fromString(rs.getString("Id")));
                skill.setName(rs.getString("Name"));
                skills.add(skill);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return skills;
    }

    public List<UUID> getSkillIdsByJobId(UUID jobId) {
        List<UUID> skillIds = new ArrayList<>();
        String sql = "SELECT SkillId FROM JobSkills WHERE JobId = ?";

        if (connection == null) {
            return skillIds;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, jobId.toString());

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    UUID skillId = UUID.fromString(rs.getString("SkillId"));
                    skillIds.add(skillId);
                }
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return skillIds;
    }

}
