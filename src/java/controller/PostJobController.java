package controller;

import dal.JobDAO;
import exception.SystemException;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
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

        try {

            // kiem tra user
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("views/pages/auth/login.jsp");
            } else {

                // lay data tu form va check valid
                String title = InputUtils.validateRequiredString(request.getParameter("title"), "Title", 255);
                String description = InputUtils.validateOptionalString(request.getParameter("description"), "Description", Integer.MAX_VALUE);
                String salary = InputUtils.validateOptionalString(request.getParameter("salary"), "Salary", 100);
                String location = InputUtils.validateOptionalString(request.getParameter("location"), "Location", 255);
                LocalDate endDate = InputUtils.validateOptionalDate(request.getParameter("endDate"), "End Date");
                Integer categoryId = InputUtils.validateOptionalInt(request.getParameter("categoryId"), "Category");
                String workingHours = InputUtils.validateOptionalString(request.getParameter("workingHours"), "Working Hours", 255);
                Integer minAge = InputUtils.validateOptionalInt(request.getParameter("minAge"), "Min age");
                Integer maxAge = InputUtils.validateOptionalInt(request.getParameter("maxAge"), "Max age");
                String[] skillIds = request.getParameterValues("skillIds");

                JobDAO dao = new JobDAO();

                // set job
                Job job = new Job();
                job.setTitle(title);
                job.setDescription(description);
                job.setSalary(salary);
                job.setLocation(location);
                if (endDate == null) {
                    job.setEndDate(null);
                } else {
                    job.setEndDate(Date.valueOf(endDate));
                }
                job.setCategoryId(categoryId);
                job.setWorkingHours(workingHours);
                job.setMinAge(minAge);
                job.setMaxAge(maxAge);
                job.setUserId(user.getId());

                // postJob
                boolean success = dao.postJob(job, skillIds);

                if (success) {
                    response.sendRedirect("views/manageJob.jsp");
                }

            }
        } catch (SystemException e) {
            request.setAttribute("error", e.getMessage());
            loadFormLists(request);
            request.getRequestDispatcher("views/postJob.jsp").forward(request, response);

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
