<%-- 
    Document   : index
    Created on : Sep 30, 2025, 1:10:11 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="/EmployeeManagement/static/css/styles.css"/>
        <title>Login</title>
    </head>
    <body>
        
        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            if (username == null) username = "";
            if (password == null) password = "";
        %>
        <div style="width: 100vw;display:flex;justify-content: center;align-items: center;margin-top: 10rem;flex-direction: column;">
            <h2 style="text-align: center;">Login Page</h2>
            <form action="Login" method="POST">

                <label>Username: </label>
                <input type="text" name="username" value="<%= username%>">

                <br>

                <label>Password: </label>
                <input type="password" name="password" value="<%= password%>">

                <br>

                <button type="submit">Login</button>

            </form>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            if (error == null) error = "";
        %>
        <div><%= error %></div>
    </body>
</html>
