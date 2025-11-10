/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.JobDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Job;

/**
 *
 * @author ngtha
 */
public class DeleteJobController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadJobLists(request);
        request.getRequestDispatcher("views/pages/job/manage.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String jobIdStr = request.getParameter("jobId");
        JobDAO dao = new JobDAO();

        try {
            int jobId = Integer.parseInt(jobIdStr);
            dao.deleteJob(jobId);
            response.sendRedirect("ListJob");
        } catch (Exception ex) {
            request.setAttribute("error", "Unable to delete job. Try again!");
            loadJobLists(request);
            request.getRequestDispatcher("views/pages/job/manage.jsp").forward(request, response);
        }

    }

    private void loadJobLists(HttpServletRequest request) {
        try {
            JobDAO jobDAO = new JobDAO();
            List<Job> jobList = jobDAO.getAllJob();

            request.setAttribute("jobList", jobList);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Try again!!.");
        }
    }

}
