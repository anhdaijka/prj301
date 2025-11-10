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
import java.util.UUID;

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

    public boolean deleteJob(int jobId) throws SQLException {
        PreparedStatement ps = null;
        boolean success = false;

        try {
            this.connection.setAutoCommit(false);

            // delete job skill
            deleteJobSkill(jobId);

            // delete job
            String sql = "DELETE FROM jobs WHERE id = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, jobId);
            int rowsAffected = ps.executeUpdate();

            // Commit Transaction
            this.connection.commit();

            // Nếu rowsAffected > 0, nghĩa là đã xóa job thành công
            success = (rowsAffected > 0);

        } catch (SQLException e) {
            // Nếu có lỗi, rollback lại tất cả thay đổi
            if (this.connection != null) {
                try {
                    this.connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            throw e;

        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.setAutoCommit(true);
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }

    // deleteJob skill
    private void deleteJobSkill(int id) throws SQLException {
        PreparedStatement ps = null;

        try {
            String sql = "DELETE FROM job_skills WHERE job_id = ?";

            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.execute();
        } finally {
            if (ps != null) {
                ps.close();
            }
        }
    }

    public List<Job> getAllJob() throws SQLException {
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Job> jobs = new ArrayList<>();

        try {
            String sql = "SELECT * FROM jobs ORDER BY created_at DESC";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                Job job = new Job();

                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setCategoryId(rs.getInt("category_id"));
                job.setSalary(rs.getString("salary"));
                job.setLocation(rs.getString("location"));
                job.setEndDate(rs.getDate("endDate"));
                job.setWorkingHours(rs.getString("working_hours"));
                job.setMinAge((Integer) rs.getObject("min_age"));
                job.setMaxAge((Integer) rs.getObject("max_age"));
                job.setExperienceLevel(rs.getString("experience_level"));
                job.setDegreeRequirement(rs.getString("degree_requirement"));
                job.setGenderRequirement(rs.getString("gender_requirement"));
                job.setDescription(rs.getString("description"));
                job.setBenefits(rs.getString("benefits"));
                job.setOtherRequirements(rs.getString("other_requirements"));
                job.setCreatedAt(rs.getTimestamp("created_at"));
                job.setUserId(rs.getObject("user_id", UUID.class));
                job.setStatus(rs.getString("status"));
                jobs.add(job);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
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
        return jobs;
    }

    private void updateJobRecord(Job job) throws SQLException {
        String sql = "UPDATE jobs SET "
                + "title = ?, description = ?, salary = ?, location = ?, endDate = ?, "
                + "category_id = ?, working_hours = ?, min_age = ?, max_age = ?, "
                + "benefits = ?, other_requirements = ?, experience_level = ?, "
                + "degree_requirement = ?, gender_requirement = ?, status = ? "
                + "WHERE id = ?";

        PreparedStatement ps = null;

        try {
            ps = connection.prepareStatement(sql);

            ps.setString(1, job.getTitle());
            ps.setString(2, job.getDescription());
            ps.setString(3, job.getSalary());
            ps.setString(4, job.getLocation());
            ps.setDate(5, job.getEndDate());
            ps.setInt(6, job.getCategoryId());
            ps.setString(7, job.getWorkingHours());

            if (job.getMinAge() != null) {
                ps.setInt(8, job.getMinAge());
            } else {
                ps.setNull(8, Types.INTEGER);
            }
            if (job.getMaxAge() != null) {
                ps.setInt(9, job.getMaxAge());
            } else {
                ps.setNull(9, Types.INTEGER);
            }

            ps.setString(10, job.getBenefits());
            ps.setString(11, job.getOtherRequirements());
            ps.setString(12, job.getExperienceLevel());
            ps.setString(13, job.getDegreeRequirement());
            ps.setString(14, job.getGenderRequirement());
            ps.setString(15, job.getStatus());
            ps.setInt(16, job.getId());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Update failed. No job found with id: " + job.getId());
            }

        } finally {
            if (ps != null) {
                ps.close();
            }
        }
    }

    public boolean updateJob(Job job, List<Integer> skillIds) throws SQLException {

        boolean success = false;

        try {
            connection.setAutoCommit(false);

            updateJobRecord(job);
            deleteJobSkill(job.getId());

            if (skillIds != null && !skillIds.isEmpty()) {
                insertJobSkills(job.getId(), skillIds);
            }

            this.connection.commit();
            success = true;

        } catch (SQLException e) {
            if (this.connection != null) {
                try {
                    this.connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            throw e;

        } finally {
            if (connection != null) {
                try {
                    this.connection.setAutoCommit(true);
                    this.connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return success;
    }

    public Job getJobById(int jobId) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Job job = null;
        try {
            String sql = "SELECT * FROM jobs WHERE id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, jobId);
            rs = stm.executeQuery();

            if (rs.next()) {
                job = new Job();

                // Lấy tất cả các trường
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setCategoryId(rs.getInt("category_id"));
                job.setSalary(rs.getString("salary"));
                job.setLocation(rs.getString("location"));
                job.setEndDate(rs.getDate("endDate"));
                job.setWorkingHours(rs.getString("working_hours"));
                job.setMinAge((Integer) rs.getObject("min_age"));
                job.setMaxAge((Integer) rs.getObject("max_age"));
                job.setExperienceLevel(rs.getString("experience_level"));
                job.setDegreeRequirement(rs.getString("degree_requirement"));
                job.setGenderRequirement(rs.getString("gender_requirement"));
                job.setDescription(rs.getString("description"));
                job.setBenefits(rs.getString("benefits"));
                job.setOtherRequirements(rs.getString("other_requirements"));
                job.setCreatedAt(rs.getTimestamp("created_at"));
                job.setUserId(rs.getObject("user_id", UUID.class));
                job.setStatus(rs.getString("status"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Đóng tất cả
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
        return job;
    }

}
