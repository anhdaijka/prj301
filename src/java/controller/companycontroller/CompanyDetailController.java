/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.companycontroller; // Đổi sang package controller cho company

import dal.CompanyDAO; // <-- 1. Thay đổi DAO
import dal.JobDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Company; // <-- 2. Thay đổi Model
import model.Job;

/**
 *
 * @author FPT (Adapted from JobDetailServlet)
 */
public class CompanyDetailController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
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
            out.println("<title>Servlet CompanyDetailServlet</title>"); // <-- 4. Sửa Title
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CompanyDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String companyIdStr = request.getParameter("id");

            if (companyIdStr == null || companyIdStr.isEmpty()) {
                response.sendRedirect("companies"); 
                return;
            }

            CompanyDAO companyDAO = new CompanyDAO();
            JobDAO jobDAO = new JobDAO(); 
            
            Company company = null;
            List<Job> companyJobs = new ArrayList<>(); 

            UUID companyId = UUID.fromString(companyIdStr);
            company = companyDAO.getCompanyById(companyId);

            if (company != null) {
                companyJobs = jobDAO.getJobsByCompanyId(company.getId()); 
                
                request.setAttribute("company", company);
                request.setAttribute("companyJobs", companyJobs); 
                request.getRequestDispatcher("/views/pages/company/details.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Company not found with ID = " + companyIdStr);
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            }

        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            response.sendRedirect("companies");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("companies");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Tốt hơn là gọi doGet, vì POST không dùng để xem chi tiết
        doGet(request, response); 
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Handles retrieving and displaying company details.";
    }// </editor-fold>

}