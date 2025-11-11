package controller.postjobcontroller;

import dal.CategoryDAO;
import dal.CompanyDAO;
import dal.JobDAO;
import dal.SkillDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Category;
import model.Company;
import model.Job;
import model.Skill;
import model.User;

public class PostJobController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            loadFormLists(request);
            request.getRequestDispatcher("views/pages/job/post.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to post job at this time.");
            request.getRequestDispatcher("views/pages/job/post.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        CompanyDAO comDao = new CompanyDAO();
        UUID companyId = comDao.getCompanyIdByUserId(user.getId());

        try {
            if (user == null) {
                response.sendRedirect("views/pages/auth/login/index.jsp");
                return;
            }

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

            UUID categoryId = UUID.fromString(categoryIdStr);
            UUID userId = user.getId();

            int salary = Integer.parseInt(salaryStr);
            Date endDate = Date.valueOf(endDateStr);

            Integer minAge = minAgeStr != null && !minAgeStr.isEmpty() ? Integer.parseInt(minAgeStr) : null;
            Integer maxAge = maxAgeStr != null && !maxAgeStr.isEmpty() ? Integer.parseInt(maxAgeStr) : null;

            // Xử lý Skill
            List<UUID> skillIds = new ArrayList<>();
            if (skillsStr != null) {
                for (String skillStr : skillsStr) {
                    skillIds.add(UUID.fromString(skillStr));
                }
            }

            Job job = new Job();
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
            job.setStatus(true);
            job.setUserId(userId);
            job.setCompanyId(companyId);

            JobDAO dao = new JobDAO();
            boolean success = dao.postJob(job, skillIds);

            if (success) {
                response.sendRedirect(request.getContextPath() +"/ListJob");
            } else {
                throw new Exception("Post Job fail. Please try again!!");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Input invalid");
            e.printStackTrace();
            loadFormLists(request);
            request.getRequestDispatcher("views/pages/job/post.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Unable to post job at this time.");
            e.printStackTrace();
            loadFormLists(request);
            response.sendRedirect(request.getContextPath() +"/ListJob");
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
