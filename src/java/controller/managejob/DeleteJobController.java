package controller.managejob;

import dal.CompanyDAO;
import dal.JobDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Job;
import model.User;

public class DeleteJobController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        UUID userId = (UUID) session.getAttribute("userId");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        loadJobLists(request, userId);
        request.getRequestDispatcher("views/pages/job/manage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        UUID userId = (UUID) session.getAttribute("userId");

        if (user == null || userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String jobIdStr = request.getParameter("jobId");
        if (jobIdStr == null || jobIdStr.isEmpty()) {
            request.setAttribute("error", "Thiếu ID công việc cần xóa.");
            loadJobLists(request, userId);
            request.getRequestDispatcher("views/pages/job/manage.jsp").forward(request, response);
            return;
        }

        JobDAO jobDAO = new JobDAO();
        CompanyDAO companyDAO = new CompanyDAO();

        try {
            UUID jobId = UUID.fromString(jobIdStr);
            UUID companyId = companyDAO.getCompanyIdByUserId(userId);

            if (companyId == null) {
                request.setAttribute("error", "Không tìm thấy công ty của bạn.");
                loadJobLists(request, userId);
                request.getRequestDispatcher("views/pages/job/manage.jsp").forward(request, response);
                return;
            }

            // Kiểm tra quyền sở hữu
            Job job = jobDAO.getJobById(jobId);
            if (job == null || !job.getCompanyId().equals(companyId)) {
                request.setAttribute("error", "Bạn không có quyền xóa công việc này.");
                loadJobLists(request, userId);
                request.getRequestDispatcher("views/pages/job/manage.jsp").forward(request, response);
                return;
            }

            boolean deleted = jobDAO.deleteJob(jobId);
            if (!deleted) {
                request.setAttribute("error", "Không thể xóa công việc (jobId không tồn tại?).");
                loadJobLists(request, userId);
                request.getRequestDispatcher("views/pages/job/manage.jsp").forward(request, response);
                return;
            }

            response.sendRedirect(request.getContextPath() + "/ListJob");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống không xác định. Vui lòng thử lại.");
            loadJobLists(request, userId);
            request.getRequestDispatcher("views/pages/job/manage.jsp").forward(request, response);
        }
    }

    private void loadJobLists(HttpServletRequest request, UUID recruiterUserId)
            throws ServletException, IOException {

        int page = 1;
        final int PAGE_SIZE = 10;

        CompanyDAO companyDAO = new CompanyDAO();
        UUID companyId = null;

        try {
            companyId = companyDAO.getCompanyIdByUserId(recruiterUserId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (companyId == null) {
            request.setAttribute("jobList", new ArrayList<Job>());
            return;
        }

        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        if (page < 1) {
            page = 1;
        }

        try {
            JobDAO jobDAO = new JobDAO();
            List<Job> jobList = jobDAO.getJobsByCompany(companyId, page, PAGE_SIZE);
            request.setAttribute("jobList", jobList);
            request.setAttribute("currentPage", page);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error load data. Try again", e);
        }
    }
}
