/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import model.User;

/**
 *
 * @author FPT
 */
public class SignupController extends HttpServlet {

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
            out.println("<title>Servlet SignupController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignupController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // 1. Nếu đã đăng nhập, không cho đăng ký nữa, chuyển về trang chủ.
        if (user != null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 2. Logic hiển thị step
        String stepParam = request.getParameter("step");
        int step = 1; // Mặc định là step 1

        if (stepParam != null) {
            try {
                step = Integer.parseInt(stepParam);
            } catch (NumberFormatException e) {
                step = 1; // Nếu param "step" không hợp lệ, quay về bước 1
            }
        }

        // Lấy dữ liệu form cũ từ session (nếu có) để điền lại
        if (session != null) {
            Map<String, String> formData = (Map<String, String>) session.getAttribute("signupData");
            if (formData != null) {
                request.setAttribute("formData", formData);
            }
        }

        // Gửi step đến JSP
        request.setAttribute("step", step);
        request.getRequestDispatcher("/views/pages/auth/signup/index.jsp").forward(request, response);
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
        HttpSession session = request.getSession();

        Map<String, String> formData = (Map<String, String>) session.getAttribute("signupData");
        if (formData == null) {
            formData = new HashMap<>();
        }

        int currentStep = 1;
        int nextStep = 2;

        try {
            currentStep = Integer.parseInt(request.getParameter("currentStep"));
            nextStep = Integer.parseInt(request.getParameter("nextStep"));
        } catch (NumberFormatException e) {
            System.out.println("Lỗi parsing step: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/signup?step=1");
            return;
        }
        switch (currentStep) {
            case 1:
                formData.put("fullname", request.getParameter("fullname"));
                formData.put("email", request.getParameter("email"));
                formData.put("password", request.getParameter("password"));
                break;
            case 2:
                formData.put("location", request.getParameter("location"));
                formData.put("postalcode", request.getParameter("postalcode"));
                break;
            case 3:
                formData.put("amount", request.getParameter("amount")); // lương
                formData.put("payment", request.getParameter("payment")); // chu kỳ
                break;
            case 4:
                formData.put("cv", request.getParameter("cv"));
                break;
        }

        session.setAttribute("signupData", formData);

        if (nextStep == 5) {
            String fullName = formData.get("fullname");
            String email = formData.get("email");
            String password = formData.get("password");
            String location = formData.get("location");
            String postalCode = formData.get("postalcode");
            String amount = formData.get("amount");      // lương tối thiểu
            String payment = formData.get("payment");      // monthly / yearly
            String resumeUrl = formData.get("cv");       // link file CV

            String avatarUrl = null;
            String phone = null;
            LocalDate birthday = null;

            Integer minimumSalary = null;
            if (amount != null && !amount.isEmpty()) {
                try {
                    minimumSalary = Integer.parseInt(amount);
                } catch (NumberFormatException e) {
                    minimumSalary = null;
                }
            }

            UUID defaultRoleId = UUID.fromString("e90cc62e-8cbc-4776-8601-c0c604367776");

            User newUser = new User(UUID.randomUUID(), fullName, email, password, location, postalCode, minimumSalary, payment, resumeUrl, avatarUrl, phone, birthday, defaultRoleId);

            UserDAO userDAO = new UserDAO();

            if (userDAO.findUser(email)) {
                request.setAttribute("error", "Email đã tồn tại!");
                request.setAttribute("step", 1); // Quay về bước 1
                request.setAttribute("formData", formData);
                request.getRequestDispatcher("/views/pages/auth/signup/index.jsp").forward(request, response);
                return;
            }
            
            boolean created = userDAO.signUp(newUser);

            if (created) {
                session.removeAttribute("signupData"); // Xóa data form khỏi session
                request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại!");
                request.setAttribute("step", 4); // Quay về bước cuối
                request.setAttribute("formData", formData);
                request.getRequestDispatcher("/views/pages/auth/signup/index.jsp").forward(request, response);
            }
            
        } else {
            response.sendRedirect(request.getContextPath() + "/signup?step=" + nextStep);
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