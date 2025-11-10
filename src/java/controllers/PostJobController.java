package controllers;

import dal.JobDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.Category;
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

        try {

            // kiem tra user
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("views/pages/auth/login/index.jsp");
                return;
            } else {
                // lay data tu form
                String title = request.getParameter("title");
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String salary = request.getParameter("salary");
                String location = request.getParameter("location");
                String endDate = request.getParameter("endDate");
                String workingHours = request.getParameter("workingHours");
                String minAgeStr = request.getParameter("minAge");
                String maxAgeStr = request.getParameter("maxAge");
                String experienceLevel = request.getParameter("experienceLevel");
                String degreeRequirement = request.getParameter("degreeRequirement");
                String benefits = request.getParameter("benefits");
                String otherRequirements = request.getParameter("otherRequirements");
                String genderRequirement = request.getParameter("genderRequirement");
                String description = request.getParameter("description");
                String[] skillsStr = request.getParameterValues("skillIds");
                String skillOther = request.getParameter("skillOther");

                JobDAO dao = new JobDAO();
                List<Integer> skillIds = new ArrayList<>();

                // xu ly skill
                if (skillsStr != null) {
                    for (String skillStr : skillsStr) {
                        int id = Integer.parseInt(skillStr);
                        skillIds.add(id);
                    }
                }
                if (skillOther != null && !skillOther.isEmpty()) {
                    String[] createSkillList = skillOther.split(",");
                    for (String skill : createSkillList) {
                        int id = dao.createSkill(skill.trim());
                        skillIds.add(id);
                    }

                }

                Integer minAge = null;
                Integer maxAge = null;

                // xu li age
                if (minAgeStr != null && !minAgeStr.isEmpty()) {
                    minAge = Integer.valueOf(minAgeStr);
                }
                if (maxAgeStr != null && !maxAgeStr.isEmpty()) {
                    maxAge = Integer.valueOf(maxAgeStr);
                }

                // set job
                Job job = new Job();
                job.setTitle(title);
                job.setCategoryId(categoryId);
                job.setSalary(salary);
                job.setLocation(location);
                job.setEndDate(Date.valueOf(endDate));
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
                    response.sendRedirect("views/pages/job/post.jsp");
                }

            }
        } catch (Exception e) {
            request.setAttribute("error", "Unable to post job at this time.");
            loadFormLists(request);
            request.getRequestDispatcher("views/pages/job/post.jsp").forward(request, response);
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
            request.setAttribute("error", "Unable to post job at this time.");
        }
    }

}
