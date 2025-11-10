<%-- 
    Document   : details
    Created on : Nov 10, 2025, 10:07:56 PM
    Author     : anhdaik
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>User Details</title>
        <jsp:include page="/static/css/styles.jsp"/>
    </head>
    <body class="bg-base-300 flex items-center justify-center h-screen">
        <div class="bg-base-100 shadow-lg rounded-xl p-8 w-full max-w-lg">
            <h2 class="text-2xl font-semibold mb-4 text-secondary">User Details</h2>

            <p><strong>Username:</strong> ${requestScope.user.username}</p>
            <p><strong>Full Name:</strong> ${requestScope.user.fullname}</p>
            <p><strong>Email:</strong> ${requestScope.user.email}</p>
            <p><strong>Phone:</strong> ${requestScope.user.phone}</p>
            <p><strong>Role:</strong> ${requestScope.user.role}</p>

            <div class="mt-6 flex justify-between">
                <a href="index.jsp" class="text-primary hover:underline">← Back</a>
                <a href="edit.jsp?id=${user.id}" class="bg-warning text-warning-content px-4 py-1 rounded hover:bg-success">Edit</a>
            </div>
        </div>
    </body>
</html>

