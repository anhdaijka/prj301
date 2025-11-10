package dal;

import java.sql.Date;
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
import java.sql.Timestamp;

public class JobDAO extends DBContext {

    private UUID insertJob(Job job) throws SQLException {

        String sqlJob = "INSERT INTO jobs (Title, Description, Salary, Location, EndDate, "
                + "Status, UserId, CompanyId, CategoryId, Working_Hours, Min_Age, Max_Age, "
                + "Experience_Level, Degree_Requirement, Gender_Requirement, Benefits, Other_Requirements, Created_At) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; // 18 tham số

        UUID newJobId = null;

        try (PreparedStatement ps = connection.prepareStatement(sqlJob, Statement.RETURN_GENERATED_KEYS)) { // tra ve id vua tao

            ps.setString(1, job.getTitle());
            ps.setString(2, job.getDescription());
            ps.setInt(3, job.getSalary());
            ps.setString(4, job.getLocation());
            ps.setDate(5, new Date(job.getEndDate().getTime()));
            ps.setBoolean(6, job.isStatus());
            ps.setObject(7, job.getUserId());
            ps.setObject(8, job.getCompanyId());
            ps.setObject(9, job.getCategoryId());
            ps.setString(10, job.getWorkingHours());
            if (job.getMinAge() != null) {
                ps.setInt(11, job.getMinAge());
            } else {
                ps.setNull(11, Types.INTEGER);
            }
            if (job.getMaxAge() != null) {
                ps.setInt(12, job.getMaxAge());
            } else {
                ps.setNull(12, Types.INTEGER);
            }
            ps.setString(13, job.getExperienceLevel());
            ps.setString(14, job.getDegreeRequirement());
            ps.setString(15, job.getGenderRequirement());
            ps.setString(16, job.getBenefits());
            ps.setString(17, job.getOtherRequirements());
            ps.setTimestamp(18, new Timestamp(System.currentTimeMillis()));

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Post Job fail. Please try again!!");
            }

            // Lấy ID tự động tạo (int)
            try (ResultSet rs = ps.getGeneratedKeys()) {
                while (rs.next()) {
                    newJobId = (UUID) rs.getObject(1);
                }
            }

            return newJobId;
        }
    }

    private void insertJobSkills(UUID newJobId, List<UUID> skillIds) throws SQLException {
        String sqlSkill = "INSERT INTO JobSkills (JobId, SkillId) VALUES (?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sqlSkill)) {

            for (UUID skillId : skillIds) {
                ps.setObject(1, newJobId);
                ps.setObject(2, skillId);
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

    public boolean postJob(Job job, List<UUID> skillIds) throws SQLException {
        boolean success = false;

        boolean originalAutoCommit = connection.getAutoCommit();

        try {
            connection.setAutoCommit(false);

            UUID newJobId = insertJob(job);

            if (skillIds != null && !skillIds.isEmpty()) {
                insertJobSkills(newJobId, skillIds);
            }

            connection.commit();
            success = true;

        } catch (SQLException e) {
            if (connection != null) {
                try {
                    System.err.print("Transaction is being rolled back due to: " + e.getMessage());
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
                    connection.setAutoCommit(originalAutoCommit);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return success;
    }

    public List<Job> getNewestJobs(int limit) {
        List<Job> jobs = new ArrayList<>();
        String sql = """
            SELECT TOP (?) 
                            j.Id, j.Title, j.Description, j.Salary, j.Location, 
                            j.EndDate, j.Status, j.CompanyId, j.CategoryId,
                            c.Name AS CompanyName, c.ImageUrl AS CompanyLogo,
                            cat.Name AS CategoryName,
                            DATEDIFF(DAY, j.EndDate, GETDATE()) AS DaysAgo
                        FROM Jobs j
                        LEFT JOIN Companies c ON j.CompanyId = c.Id
                        LEFT JOIN Categories cat ON j.CategoryId = cat.Id
                        WHERE j.Status = 'True'
                        ORDER BY j.EndDate DESC
        """;

        if (connection == null) {
            System.err.println("ERROR: Database connection is NULL!");
            return jobs;
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, limit);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Job job = extractJobFromResultSet(rs);

                    // Load skills cho job này
                    job.setSkills(getJobSkills(job.getId()));

                    jobs.add(job);
                }
            }

            System.out.println("Loaded " + jobs.size() + " newest jobs");

        } catch (SQLException ex) {
            System.err.println("SQL Error in getNewestJobs: " + ex.getMessage());
            ex.printStackTrace();
        }

        return jobs;
    }

    public List<Job> getAllJobs(int page, int pageSize) {
        List<Job> jobs = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = """
        SELECT 
            j.Id, j.Title, j.Description, j.Salary, j.Location, 
            j.EndDate, j.Status, j.CompanyId, j.CategoryId,
            c.Name AS CompanyName, c.ImageUrl AS CompanyLogo,
            cat.Name AS CategoryName,
            DATEDIFF(DAY, j.EndDate, GETDATE()) AS DaysAgo
        FROM Jobs j
        LEFT JOIN Companies c ON j.CompanyId = c.Id
        LEFT JOIN Categories cat ON j.CategoryId = cat.Id
        WHERE j.Status = 1
        ORDER BY j.EndDate DESC
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, offset);
            stm.setInt(2, pageSize);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Job job = extractJobFromResultSet(rs);
                    job.setSkills(getJobSkills(job.getId()));
                    jobs.add(job);
                }
            }

            System.out.println("getAllJobs: Loaded " + jobs.size() + " jobs (page " + page + ")");

        } catch (SQLException ex) {
            System.err.println("SQL Error in getAllJobs: " + ex.getMessage());
            ex.printStackTrace();
        }

        return jobs;
    }

    public Job getJobById(UUID jobId) {
        String sql = """
            SELECT 
                j.Id, j.Title, j.Description, j.Salary, j.Location, 
                j.EndDate, j.Status, j.CompanyId, j.CategoryId, j.UserId,
                c.Name AS CompanyName, c.Logo AS CompanyLogo,
                cat.Name AS CategoryName,
                DATEDIFF(DAY, j.EndDate, GETDATE()) AS DaysAgo
            FROM Jobs j
            LEFT JOIN Companies c ON j.CompanyId = c.Id
            LEFT JOIN Categories cat ON j.CategoryId = cat.Id
            WHERE j.Id = ?
        """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, jobId.toString());

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    Job job = extractJobFromResultSet(rs);
                    job.setSkills(getJobSkills(job.getId()));
                    return job;
                }
            }

        } catch (SQLException ex) {
            System.err.println("SQL Error in getJobById: " + ex.getMessage());
            ex.printStackTrace();
        }

        return null;
    }

    public List<Job> getJobsByCategory(UUID categoryId) {
        List<Job> jobs = new ArrayList<>();
        String sql = """
            SELECT 
                j.Id, j.Title, j.Description, j.Salary, j.Location, 
                j.EndDate, j.Status, j.CompanyId, j.CategoryId,
                c.Name AS CompanyName, c.Logo AS CompanyLogo,
                cat.Name AS CategoryName,
                DATEDIFF(DAY, j.EndDate, GETDATE()) AS DaysAgo
            FROM Jobs j
            LEFT JOIN Companies c ON j.CompanyId = c.Id
            LEFT JOIN Categories cat ON j.CategoryId = cat.Id
            WHERE j.CategoryId = ? AND j.Status = 'Active'
            ORDER BY j.EndDate DESC
        """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, categoryId.toString());

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Job job = extractJobFromResultSet(rs);
                    job.setSkills(getJobSkills(job.getId()));
                    jobs.add(job);
                }
            }

        } catch (SQLException ex) {
            System.err.println("SQL Error in getJobsByCategory: " + ex.getMessage());
            ex.printStackTrace();
        }

        return jobs;
    }

    private List<String> getJobSkills(UUID jobId) {
        List<String> skills = new ArrayList<>();
        String sql = """
            SELECT s.Name
            FROM JobSkills js
            INNER JOIN Skills s ON js.SkillId = s.Id
            WHERE js.JobId = ?
        """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, jobId.toString());

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    skills.add(rs.getString("Name"));
                }
            }

        } catch (SQLException ex) {
            System.err.println("SQL Error in getJobSkills: " + ex.getMessage());
        }

        return skills;
    }

    public int getTotalJobs() {
        String sql = "SELECT COUNT(*) FROM Jobs WHERE Status = 'True'";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.err.println("SQL Error in getTotalJobs: " + ex.getMessage());
        }

        return 0;
    }

    public List<Job> searchJobs(String keyword) {
        List<Job> jobs = new ArrayList<>();
        String sql = """
             SELECT 
                            j.Id, j.Title, j.Description, j.Salary, j.Location, 
                            j.EndDate, j.Status, j.CompanyId, j.CategoryId,
                            c.Name AS CompanyName, c.ImageUrl AS CompanyLogo,
                            cat.Name AS CategoryName,
                            DATEDIFF(DAY, j.EndDate, GETDATE()) AS DaysAgo
                        FROM Jobs j
                        LEFT JOIN Companies c ON j.CompanyId = c.Id
                        LEFT JOIN Categories cat ON j.CategoryId = cat.Id
                        WHERE j.Status = 'True' 
                            AND (j.Title LIKE ? OR j.Description LIKE ? OR c.Name LIKE ?)
                        ORDER BY j.EndDate DESC
        """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stm.setString(1, searchPattern);
            stm.setString(2, searchPattern);
            stm.setString(3, searchPattern);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Job job = extractJobFromResultSet(rs);
                    job.setSkills(getJobSkills(job.getId()));
                    jobs.add(job);
                }
            }

        } catch (SQLException ex) {
            System.err.println("SQL Error in searchJobs: " + ex.getMessage());
            ex.printStackTrace();
        }

        return jobs;
    }

    private Job extractJobFromResultSet(ResultSet rs) throws SQLException {
        Job job = new Job();
        job.setId(UUID.fromString(rs.getString("Id")));
        job.setTitle(rs.getString("Title"));
        job.setDescription(rs.getString("Description"));
        job.setSalary(rs.getInt("Salary"));
        job.setLocation(rs.getString("Location"));
        job.setEndDate(rs.getDate("EndDate"));
        job.setStatus(rs.getBoolean("Status"));
        job.setCompanyId(rs.getString("CompanyId") != null
                ? UUID.fromString(rs.getString("CompanyId")) : null);
        job.setCategoryId(rs.getString("CategoryId") != null
                ? UUID.fromString(rs.getString("CategoryId")) : null);

        // Thông tin bổ sung
        job.setCompanyName(rs.getString("CompanyName"));
        job.setCompanyLogo(rs.getString("CompanyLogo"));
        job.setCategoryName(rs.getString("CategoryName"));
        job.setDaysAgo(rs.getInt("DaysAgo"));

        return job;
    }
}
