/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.companycontroller; // Bạn có thể đổi tên package này

import dal.CompanyDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Company; 

/**
 *
 * @author FPT (Adapted by Gemini)
 */

public class FindCompanyController extends HttpServlet {

    /**
     * Processes requests for both HTTP GET and POST methods.
     * (Đây là code boilerplate, bạn có thể giữ hoặc xóa nó)
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchCompanyController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchCompanyController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP GET method.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CompanyDAO dao = new CompanyDAO(); 
        String keyword = request.getParameter("keyword");

        List<Company> companies = new ArrayList<>(); 
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            companies = dao.searchCompanies(keyword.trim());
        } else {
            companies = dao.getAllCompanies(1, 50); 
        }

        if (companies == null) {
            companies = new ArrayList<>();
        }

        System.out.println("Final companies size: " + companies.size());

        request.setAttribute("companies", companies);
        request.setAttribute("keyword", keyword);
        request.setAttribute("totalCompanies", companies.size()); 

        request.getRequestDispatcher("/views/pages/company/index.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP POST method.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chỉ cần gọi doGet
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Servlet for searching and listing companies";
    }// </editor-fold>

}