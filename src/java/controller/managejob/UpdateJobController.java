package controller.managejob;

import dal.JobDAO;
import dal.CategoryDAO;
import dal.SkillDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.UUID;
import java.sql.Date;
import java.util.ArrayList;
import model.Category;
import model.Job;
import model.Skill;

public class UpdateJobController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        Job job = null;

        try {
            if (idStr != null && !idStr.isEmpty()) {
                UUID jobId = UUID.fromString(idStr);
                JobDAO dao = new JobDAO();
                job = dao.getJobById(jobId);
            }

            loadFormLists(request);

            request.setAttribute("job", job);
            request.getRequestDispatcher("/views/pages/job/update.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "ID công việc không hợp lệ.");
            loadFormLists(request);
            request.getRequestDispatcher("/views/pages/job/update.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Không thể tải dữ liệu.");
            request.getRequestDispatcher("/views/pages/job/update.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            String jobIdStr = request.getParameter("id");
            String title = request.getParameter("title");
            String categoryIdStr = request.getParameter("categoryId");
            String salaryStr = request.getParameter("salary");
            String location = request.getParameter("location");
            String endDateStr = request.getParameter("endDate");
            String description = request.getParameter("description");
            String[] skillsStr = request.getParameterValues("skillIds");

            String minAgeStr = request.getParameter("minAge");
            String maxAgeStr = request.getParameter("maxAge");
            String workingHours = request.getParameter("workingHours");
            String experienceLevel = request.getParameter("experienceLevel");
            String degreeRequirement = request.getParameter("degreeRequirement");
            String benefits = request.getParameter("benefits");
            String otherRequirements = request.getParameter("otherRequirements");
            String genderRequirement = request.getParameter("genderRequirement");

            UUID jobId = UUID.fromString(jobIdStr);
            UUID categoryId = UUID.fromString(categoryIdStr);

            int salary = Integer.parseInt(salaryStr);
            java.util.Date endDate = Date.valueOf(endDateStr);

            Integer minAge = minAgeStr != null && !minAgeStr.isEmpty() ? Integer.parseInt(minAgeStr) : null;
            Integer maxAge = maxAgeStr != null && !maxAgeStr.isEmpty() ? Integer.parseInt(maxAgeStr) : null;

            List<UUID> skillIds = new ArrayList<>();
            if (skillsStr != null) {
                for (String skillStr : skillsStr) {
                    skillIds.add(UUID.fromString(skillStr));
                }
            }

            JobDAO jobDAO = new JobDAO();
            Job job = jobDAO.getJobById(jobId);

            if (job == null) {
                throw new Exception("Không tìm thấy Job cần cập nhật.");
            }

            // Cập nhật các trường từ form
            job.setId(jobId); // Đảm bảo ID được set
            job.setTitle(title);
            job.setCategoryId(categoryId);
            job.setSalary(salary);
            job.setLocation(location);
            job.setEndDate(endDate);
            job.setWorkingHours(workingHours);
            job.setMinAge(minAge);
            job.setMaxAge(maxAge);
            job.setExperienceLevel(experienceLevel);
            job.setDegreeRequirement(degreeRequirement);
            job.setBenefits(benefits);
            job.setOtherRequirements(otherRequirements);
            job.setGenderRequirement(genderRequirement);
            job.setDescription(description);

            jobDAO.updateJob(job, skillIds);

            // Chuyển hướng thành công
            response.sendRedirect(request.getContextPath() + "/ListJob?success=update");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Lỗi dữ liệu đầu vào. Vui lòng kiểm tra các trường số và ID.");
            e.printStackTrace();
            loadFormLists(request);
            request.getRequestDispatcher("/views/pages/job/update.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
            e.printStackTrace();
            loadFormLists(request);
            request.getRequestDispatcher("/views/pages/job/update.jsp").forward(request, response);
        }
    }

    private void loadFormLists(HttpServletRequest request) throws ServletException {
        try {
            CategoryDAO categoryDAO = new CategoryDAO();
            SkillDAO skillDAO = new SkillDAO();

            List<Category> categoryList = categoryDAO.getAllCategoriesWithJobCount();
            List<Skill> skillList = skillDAO.getAllSkills();

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("skillList", skillList);
        } catch (Exception e) {
            throw new ServletException("Lỗi tải danh sách Category/Skill.", e);
        }
    }
}
