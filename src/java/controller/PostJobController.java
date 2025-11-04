package controller;

import dal.JobDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Category;
import model.Job;
import model.Skill;
import model.User;
import utils.InputUtils;

public class PostJobController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            JobDAO categoryDAO = new JobDAO();
            List<Category> categoryList = categoryDAO.getAllCategories();

            JobDAO skillDAO = new JobDAO();
            List<Skill> skillList = skillDAO.getAllSkills();

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("skillList", skillList);
            request.getRequestDispatcher("views/postJob.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Can not load data. Try again !");
            request.getRequestDispatcher("views/postJob.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        Map<String, String> errors = new HashMap<String, String>();
        try {

            // kiem tra user
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("views/pages/auth/login.jsp");
            } else {
                // lay data tu form va check valid
                String title = InputUtils.validateRequiredString(request.getParameter("title"), "Title", 255, errors);
                int categoryId = InputUtils.validateRequiredSelect(request.getParameter("categoryId"), "Category", errors);
                String salary = InputUtils.validateOptionalString(request.getParameter("salary"), "Salary", 100, errors);
                String location = InputUtils.validateRequiredString(request.getParameter("location"), "Location", 255, errors);
                LocalDate endDate = InputUtils.validateOptionalDate(request.getParameter("endDate"), "End Date", errors);
                String workingHours = InputUtils.validateOptionalString(request.getParameter("workingHours"), "Working Hours", 255, errors);
                Integer minAge = InputUtils.validateOptionalInt(request.getParameter("minAge"), "Min age", errors);
                Integer maxAge = InputUtils.validateOptionalInt(request.getParameter("maxAge"), "Max age", errors);
                String experienceLevel = InputUtils.validateOptionalString(request.getParameter("experienceLevel"), "Experience Level", 100, errors);
                String degreeRequirement = InputUtils.validateOptionalString(request.getParameter("degreeRequirement"), "Degree Requirement", 100, errors);
                String benefits = InputUtils.validateOptionalString(request.getParameter("benefits"), "Benefits", Integer.MAX_VALUE, errors);
                String otherRequirements = InputUtils.validateOptionalString(request.getParameter("otherRequirements"), "Other Requirements", Integer.MAX_VALUE, errors);
                String genderRequirement = InputUtils.validateOptionalString(request.getParameter("genderRequirement"), "Gender Requirement", 50, errors);
                String description = InputUtils.validateOptionalString(request.getParameter("description"), "Description", Integer.MAX_VALUE, errors);

                String skillsStr = request.getParameter("skillIds");

                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    loadFormLists(request);
                    request.getRequestDispatcher("views/postJob.jsp").forward(request, response);
                } else {
                    JobDAO dao = new JobDAO();
                    List<Integer> skillIds = new ArrayList<>();

                    // xu ly skill
                    if (skillsStr != null && !skillsStr.trim().isEmpty()) {
                        String[] skillNames = skillsStr.split(",");

                        for (String skillName : skillNames) {
                            if (!skillName.trim().isEmpty()) {
                                JobDAO daoSkill = new JobDAO();
                                int skillId = daoSkill.createSkill(skillName.trim());
                                skillIds.add(skillId);
                            }
                        }
                    }

                    // set job
                    Job job = new Job();
                    job.setTitle(title);
                    job.setCategoryId(categoryId);
                    job.setSalary(salary);
                    job.setLocation(location);
                    if (endDate == null) {
                        job.setEndDate(null);
                    } else {
                        job.setEndDate(Date.valueOf(endDate));
                    }
                    job.setWorkingHours(workingHours);
                    job.setMinAge(minAge);
                    job.setMaxAge(maxAge);
                    job.setExperienceLevel(experienceLevel);
                    job.setDegreeRequirement(degreeRequirement);
                    job.setBenefits(benefits);
                    job.setOtherRequirements(otherRequirements);
                    job.setGenderRequirement(genderRequirement);
                    job.setDescription(description);
                    job.setUserId(user.getId());

                    // postJob
                    boolean success = dao.postJob(job, skillIds);

                    if (success) {
                        response.sendRedirect("views/manageJob.jsp");
                    }

                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "A system error occurred: " + e.getMessage());
            loadFormLists(request);
            request.getRequestDispatcher("views/postJob.jsp").forward(request, response);
        }

    }

    private void loadFormLists(HttpServletRequest request) {
        try {
            JobDAO categoryDAO = new JobDAO();
            List<Category> categoryList = categoryDAO.getAllCategories();

            JobDAO skillDAO = new JobDAO();
            List<Skill> skillList = skillDAO.getAllSkills();

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("skillList", skillList);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to reload form data. Please try again.");
        }
    }

}
