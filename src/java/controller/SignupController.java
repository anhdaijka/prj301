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
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<h1>Servlet SignupController at " + request.getContextPath () + "</h1>");
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

        // 2. Cập nhật dữ liệu từ form của bước hiện tại vào Map (Logic file 1)
        // (Giả sử các bước của bạn thu thập các thông tin này)
        switch (currentStep) {
            case 1: // Bước 1: Email, Password, Tên
                formData.put("email", request.getParameter("email"));
                formData.put("password", request.getParameter("password"));
                // (Giả sử bạn có check "confirm password" ở phía client)
                break;
            case 2: // Bước 2: Tên, Điện thoại
                formData.put("name", request.getParameter("name"));
                formData.put("phone", request.getParameter("phone"));
                break;
            case 3: // Bước 3: Ngày sinh, Avatar (URL)
                formData.put("birthday", request.getParameter("birthday")); // Sẽ có dạng "YYYY-MM-DD"
                formData.put("avatarUrl", request.getParameter("avatarUrl"));
                break;
            // Thêm các case khác nếu bạn có nhiều bước hơn
        }

        // 3. Lưu lại Map vào session
        session.setAttribute("signupData", formData);
        
        // 4. Kiểm tra xem đây có phải bước cuối cùng không (Logic từ file 1)
        // (Giả sử bước cuối là 3, và "nextStep" sẽ là 4)
        if (nextStep == 4) { // ĐIỀU CHỈNH SỐ 4 NÀY thành (số bước cuối + 1)
            
            // === BẮT ĐẦU LOGIC XỬ LÝ DATABASE (Logic từ file 2) ===
            
            // Lấy toàn bộ dữ liệu từ Map
            String email = formData.get("email");
            String password = formData.get("password");
            String name = formData.get("name");
            String phone = formData.get("phone");
            String birthdayStr = formData.get("birthday");
            String avatarUrl = formData.get("avatarUrl");
            
            UserDAO userDAO = new UserDAO();
            
            // 4.1. Kiểm tra Email tồn tại
            if (userDAO.findUser(email)) {
                request.setAttribute("error", "Email đã tồn tại!");
                request.setAttribute("step", 1); // Quay lại bước 1
                request.setAttribute("formData", formData); // Giữ lại data cũ
                request.getRequestDispatcher("/views/pages/auth/signup/index.jsp").forward(request, response);
                return;
            }
            
            // 4.2. Parse ngày sinh (Fix lỗi từ file 2)
            LocalDate birthday = null;
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                try {
                    birthday = LocalDate.parse(birthdayStr);
                } catch (DateTimeParseException e) {
                    System.out.println("Lỗi parse ngày sinh: " + e.getMessage());
                    // Có thể set lỗi và quay lại form
                }
            }

            // 4.3. Tạo đối tượng User (Giả sử RoleId là null khi đăng ký)
            // (Bạn phải đảm bảo hàm signUp trong DAO xử lý việc gán RoleId mặc định)
            User newUser = new User(UUID.randomUUID(), email, password, name, phone, birthday, avatarUrl, null);

            // 4.4. Gọi DAO để đăng ký
            boolean created = userDAO.signUp(newUser);

            // 4.5. Xử lý kết quả
            if (created) {
                // Đăng ký thành công
                session.removeAttribute("signupData"); // Xóa session
                request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
                // Chuyển đến trang login (Logic từ file 1)
                request.getRequestDispatcher("/views/pages/auth/login/index.jsp").forward(request, response);
            } else {
                // Đăng ký thất bại
                request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại!");
                request.setAttribute("step", 3); // Quay lại bước cuối (Điều chỉnh số này)
                request.setAttribute("formData", formData);
                request.getRequestDispatcher("/views/pages/auth/signup/index.jsp").forward(request, response);
            }
            return; // Rất quan trọng, để không chạy code bên dưới
        }

        // 5. Nếu chưa phải bước cuối, chuyển đến bước tiếp theo (Logic file 1)
        request.setAttribute("step", nextStep);
        request.setAttribute("formData", formData); // Gửi data để điền lại form
        request.getRequestDispatcher("/views/pages/auth/signup/index.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
