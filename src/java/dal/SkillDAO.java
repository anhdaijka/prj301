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

        String sql = "SELECT * FROM Skills ORDER BY name";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                Skill skill = new Skill();

                skill.setId((UUID) rs.getObject("Id"));
                skill.setName(rs.getString("Name"));
                skills.add(skill);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return skills;
    }
}
