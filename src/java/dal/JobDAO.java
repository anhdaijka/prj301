package dal;

import model.Category;
import model.Job;
import model.Skill;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class JobDAO extends DBContext {

    // get all categories
    public List<Category> getAllCategories() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Category> categories = new ArrayList<>();

        try {
            String sql = "SELECT id, name FROM categories ORDER BY name";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (connection != null) {
                    connection.close();
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return categories;
    }

    // get all skills
    public List<Skill> getAllSkills() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Skill> skills = new ArrayList<>();

        try {
            String sql = "SELECT id, name FROM skills ORDER BY name";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                Skill skill = new Skill();
                skill.setId(rs.getInt("id"));
                skill.setName(rs.getString("name"));
                skills.add(skill);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return skills;
    }

    // insert into table job
    private int insertJob(Job job) throws SQLException {
        String sqlJob = "INSERT INTO jobs (title, description, salary, location, endDate, "
                + "user_id, category_id, working_hours, min_age, max_age, "
                + "benefits, other_requirements, experience_level, degree_requirement, gender_requirement, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement ps = null;
        ResultSet rs = null;
        int newJobId = -1;

        try {
            ps = connection.prepareStatement(sqlJob, Statement.RETURN_GENERATED_KEYS); // tra ve id vua sinh ra

            ps.setString(1, job.getTitle());
            ps.setString(2, job.getDescription());
            ps.setString(3, job.getSalary());
            ps.setString(4, job.getLocation());
            ps.setDate(5, job.getEndDate());
            ps.setObject(6, job.getUserId());
            ps.setInt(7, job.getCategoryId());
            ps.setString(8, job.getWorkingHours());

            // age allow null
            if (job.getMinAge() != null) {
                ps.setInt(9, job.getMinAge());
            } else {
                ps.setNull(9, Types.INTEGER);
            }
            if (job.getMaxAge() != null) {
                ps.setInt(10, job.getMaxAge());
            } else {
                ps.setNull(10, Types.INTEGER);
            }

            ps.setString(11, job.getBenefits());
            ps.setString(12, job.getOtherRequirements());
            ps.setString(13, job.getExperienceLevel());
            ps.setString(14, job.getDegreeRequirement());
            ps.setString(15, job.getGenderRequirement());
            ps.setString(16, "open");

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Create job fail!!");
            }

            // getID new create
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                newJobId = rs.getInt(1);
            } else {
                throw new SQLException("Failed to get generated job ID.");
            }

            return newJobId;

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
    }

    private void insertJobSkills(int newJobId, List<Integer> skillIds) throws SQLException {
        String sqlSkill = "INSERT INTO job_skills (job_id, skill_id) VALUES (?, ?)";

        PreparedStatement ps = null;

        try {
            ps = connection.prepareStatement(sqlSkill);

            for (int skillId : skillIds) {
                ps.setInt(1, newJobId);
                ps.setInt(2, skillId);
                ps.addBatch();
            }
            ps.executeBatch();

        } finally {
            if (ps != null) {
                ps.close();
            }
        }
    }

    private int findSkillByName(String skillName) throws SQLException {
        if (skillName == null) {
            return 0;
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT id FROM skills WHERE UPPER(name) = UPPER(?)";
            ps = connection.prepareStatement(sql);
            ps.setString(1, skillName.trim());
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("id");
            }
            return 0;

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
    }

    // create skill if not find
    public int createSkill(String skillName) throws SQLException {

        // if find -> return 
        int id = findSkillByName(skillName);
        if (id != 0) {
            if (connection != null) {
                connection.close();
            }
            return id;
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        // create
        try {
            String sql = "INSERT INTO skills (name) VALUES (?)";

            ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, skillName.trim());
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                throw new SQLException("Failed to create new skill.");
            }

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    }

    // post job
    public boolean postJob(Job job, List<Integer> skillIds) throws SQLException {
        boolean success = false;

        try {

            // off auto commit
            this.connection.setAutoCommit(false);

            // insert job
            int newJobId = insertJob(job);

            // insert skill with job new insert
            if (skillIds != null) {
                insertJobSkills(newJobId, skillIds);
            }

            connection.commit();
            success = true;

        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            throw e;

        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return success;
    }
}
