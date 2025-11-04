/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author anhdaik
 */
public class SignUpController extends HttpServlet {

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
            out.println("<title>Servlet SignUpController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUpController at " + request.getContextPath() + "</h1>");
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

        // Lấy step từ request parameter
        String stepParam = request.getParameter("step");
        int step = 1; // mặc định là step1

        if (stepParam != null) {
            try {
                step = Integer.parseInt(stepParam);
            } catch (NumberFormatException e) {
                step = 1;
            }
        }

        // Gửi step đến JSP
        request.setAttribute("step", step);
        request.getRequestDispatcher("views/pages/auth/signup/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        // Lấy hoặc tạo mới map chứa dữ liệu người dùng
        Map<String, String> formData = (Map<String, String>) session.getAttribute("signupData");
        if (formData == null) {
            formData = new HashMap<>();
        }

        int currentStep = Integer.parseInt(request.getParameter("currentStep"));
        int nextStep = Integer.parseInt(request.getParameter("nextStep"));

        // Cập nhật dữ liệu theo step hiện tại
        switch (currentStep) {
            case 1:
                formData.put("username", request.getParameter("email"));
                formData.put("password", request.getParameter("password"));
                formData.put("fullname", request.getParameter("fullname"));
                break;
            case 2:
                formData.put("location", request.getParameter("location"));
                break;
            case 3:
                formData.put("amount", request.getParameter("amount"));
                break;
            case 4:
                formData.put("cv", request.getParameter("cv"));
                break;
        }

        // Lưu lại session
        session.setAttribute("signupData", formData);

        // xử lý đăng ký sau bước cuối
         if (nextStep == 5) {
            // Log tạm ra console
            System.out.println("=== User Registered ===");
            System.out.println(formData);
            
            // ====================== Hàm đăng ký ở backend ===========================
            
            
            // ========================================================================

            // Xóa session sau khi đăng ký xong
            session.removeAttribute("signupData");

            request.setAttribute("message", "Đăng ký thành công!");
            // Ra login
            request.getRequestDispatcher("views/pages/auth/login/index.jsp").forward(request, response);
            return;
        }

        // Chuyển đến bước tiếp theo
        request.setAttribute("step", nextStep);
        request.getRequestDispatcher("views/pages/auth/signup/index.jsp").forward(request, response);
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
