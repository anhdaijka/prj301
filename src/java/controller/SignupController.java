/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
        //processRequest(request, response);
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // 1. Kiểm tra xem user đã đăng nhập chưa (Logic từ file 2)
        // Nếu đã đăng nhập, không cho đăng ký nữa, chuyển về trang chủ.
        if (user != null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 2. Logic hiển thị step (Logic từ file 1)
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
        // phòng trường hợp người dùng bấm "Back"
        Map<String, String> formData = (Map<String, String>) session.getAttribute("signupData");
        if (formData != null) {
            request.setAttribute("formData", formData);
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
        //processRequest(request, response);
        HttpSession session = request.getSession();

        // 1. Lấy hoặc tạo Map để lưu dữ liệu form (Logic từ file 1)
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
        }

        switch (currentStep) {
            case 1:
                formData.put("email", request.getParameter("email"));
                formData.put("password", request.getParameter("password"));
                break;
            case 2:
                formData.put("name", request.getParameter("name"));
                formData.put("postalcode", request.getParameter("postalcode"));
                break;
            case 3:
                formData.put("amount", request.getParameter("amount")); // Sẽ có dạng "YYYY-MM-DD"
                formData.put("payment", request.getParameter("payment"));
                break;
            case 4:
                formData.put("cv", request.getParameter("cv"));
                break;
        }

        session.setAttribute("signupData", formData);

        if (nextStep == 5) {
            String email = formData.get("email");
            String password = formData.get("password");
            String fullName = formData.get("name");
            String postalCode = formData.get("postalcode");
            String amount = formData.get("amount");       // lương tối thiểu
            String payment = formData.get("payment");     // monthly / yearly
            String resumeUrl = formData.get("cv");        // link file CV

            // Các trường không có trong form → để null
            String location = null;
            String avatarUrl = null;
            String phone = null;
            LocalDate birthday = null;

            // Parse minimumSalary từ amount (nếu có)
            Integer minimumSalary = null;
            if (amount != null && !amount.isEmpty()) {
                try {
                    minimumSalary = Integer.parseInt(amount);
                } catch (NumberFormatException e) {
                    minimumSalary = null;
                }
            }

            // RoleId mặc định (ví dụ: User role)
            UUID defaultRoleId = UUID.fromString("92eb5931-6ba6-4ad9-b5bd-caf70a152246");

            // === Tạo đối tượng User theo constructor mới ===
            User newUser = new User(
                    UUID.randomUUID(), // id
                    fullName, // fullName
                    email, // email
                    password, // password
                    location, // location
                    postalCode, // postalCode
                    minimumSalary, // minimumSalary
                    payment, // paymentPeriod
                    resumeUrl, // resumeUrl
                    avatarUrl, // avatarUrl
                    phone, // phone
                    birthday, // birthday
                    defaultRoleId // roleId
            );

            // === Gọi DAO để lưu ===
            UserDAO userDAO = new UserDAO();

            if (userDAO.findUser(email)) {
                request.setAttribute("error", "Email đã tồn tại!");
                request.setAttribute("step", 1);
                request.setAttribute("formData", formData);
                request.getRequestDispatcher("/views/pages/auth/signup/index.jsp").forward(request, response);
                return;
            }

            boolean created = userDAO.signUp(newUser);

            if (created) {
                session.removeAttribute("signupData");
                request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("/views/pages/auth/login/index.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại!");
                request.setAttribute("step", 3);
                request.setAttribute("formData", formData);
                request.getRequestDispatcher("/views/pages/auth/signup/index.jsp").forward(request, response);
            }
            return;
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
