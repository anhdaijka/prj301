package controller.managejob;

import dal.JobDAO;
import dal.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Job;
import model.User;

public class ListJobController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        UUID userId = (UUID) session.getAttribute("userId");

        // 1. Kiểm tra User đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Lấy Job List (đã lọc theo công ty)
            loadJobLists(request, userId);
            request.getRequestDispatcher("/views/pages/job/manage.jsp").forward(request, response);

        } catch (ServletException e) {
            // Lỗi từ loadJobLists (CSDL, không tìm thấy công ty)
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/pages/job/manage.jsp").forward(request, response);
        } catch (Exception e) {
            // Lỗi hệ thống chung
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống không xác định. Vui lòng thử lại.");
            request.getRequestDispatcher("/views/pages/job/manage.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    private void loadJobLists(HttpServletRequest request, UUID recruiterUserId) throws ServletException, IOException {

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
