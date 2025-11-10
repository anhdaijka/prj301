/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.applyjob;

import dal.ApplicationDAO;
import dal.JobDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.UUID;
import model.Application;
import model.Job;
import model.User;

/**
 *
 * @author FPT
 */
public class ApplyController extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();
    private final ApplicationDAO appDAO = new ApplicationDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ApplyController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplyController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        try {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            if (user == null) {
                response.sendRedirect("login?redirect=apply?id=" + request.getParameter("id"));
                return;
            }

            String jobId = request.getParameter("id");
            Job job = jobDAO.getJobById(UUID.fromString(jobId)); 

            if (job == null || job.getDaysAgo() >= 0) { 
                request.setAttribute("errorMessage", "This job is not available or has expired.");
            } else {
                boolean hasApplied = appDAO.hasUserApplied(user.getId().toString(), jobId); // Cần viết hàm này
                if (hasApplied) {
                    request.setAttribute("errorMessage", "You have already applied for this job.");
                }
                request.setAttribute("job", job);
            }

            request.getRequestDispatcher("/views/pages/job/apply.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("search");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        try {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            if (user == null) {
                response.sendRedirect("login");
                return;
            }

            String jobId = request.getParameter("jobId");
            String cvSnapshot = request.getParameter("cvSnapshot");
            String note = request.getParameter("note");

            String userId = user.getId().toString(); 

            if (appDAO.hasUserApplied(userId, jobId)) {
                // Nếu đã apply, gửi lại form với thông báo lỗi
                Job job = jobDAO.getJobById(UUID.fromString(jobId));
                request.setAttribute("job", job);
                request.setAttribute("errorMessage", "You have already applied for this job.");
                request.getRequestDispatcher("/views/pages/job/apply.jsp").forward(request, response);
                return;
            }

            Application newApp = new Application();
            
            newApp.setId(UUID.randomUUID().toString()); 
            newApp.setUserId(userId); // Phải khớp kiểu dữ liệu
            newApp.setJobId(jobId); // Phải khớp kiểu dữ liệu
            newApp.setStatus("Pending"); // Giá trị mặc định
            newApp.setNote(note);
            newApp.setCvSnapshot(cvSnapshot);
            newApp.setAppliedAt(new Date()); // Ngày giờ hiện tại

            appDAO.createApplication(newApp); // Cần viết hàm này

            response.sendRedirect("apply-success"); 

        } catch (Exception e) {
            e.printStackTrace();
            String jobId = request.getParameter("jobId");
            Job job = jobDAO.getJobById(UUID.fromString(jobId));
            request.setAttribute("job", job);
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("/views/pages/job/apply.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
