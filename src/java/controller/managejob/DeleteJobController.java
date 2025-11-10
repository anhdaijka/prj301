package controller.managejob;

import dal.JobDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.UUID;
import model.Job;

public class DeleteJobController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadJobLists(request);
        request.getRequestDispatcher("/views/pages/job/manage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String jobIdStr = request.getParameter("jobId");
        JobDAO dao = new JobDAO();

        try {
            UUID jobId = UUID.fromString(jobIdStr);
            dao.deleteJob(jobId);
            response.sendRedirect("/ListJob?success=delete");

        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", "ID công việc không hợp lệ. Vui lòng thử lại!");
            ex.printStackTrace();
            loadJobLists(request);
            request.getRequestDispatcher("/views/pages/job/manage.jsp").forward(request, response);

        } catch (Exception ex) {
            request.setAttribute("error", "Không thể xóa công việc. Lỗi hệ thống: " + ex.getMessage());
            ex.printStackTrace();
            loadJobLists(request);
            request.getRequestDispatcher("/views/pages/job/manage.jsp").forward(request, response);
        }
    }

    private void loadJobLists(HttpServletRequest request) throws ServletException, IOException {

        int page = 1;
        final int PAGE_SIZE = 10;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid page number format: " + e.getMessage());
            page = 1;
        }

        if (page < 1) {
            page = 1;
        }

        try {
            JobDAO jobDAO = new JobDAO();

            List<Job> jobList = jobDAO.getAllJobs(page, PAGE_SIZE);

            request.setAttribute("jobList", jobList);
            request.setAttribute("currentPage", page);

        } catch (Exception e) {
            e.printStackTrace();

            throw new ServletException("Lỗi tải danh sách công việc khi phân trang.", e);
        }
    }

}
