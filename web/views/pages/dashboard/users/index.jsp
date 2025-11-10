<%-- 
    Document   : index
    Created on : Nov 10, 2025, 10:07:19 PM
    Author     : anhdaik
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<c:if test="${sessionScope.role ne 'Admin'}">
    <c:redirect url="/login"/>
</c:if>--%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Users</title>
        <jsp:include page="/static/css/styles.jsp"/>
    </head>
    <body class="bg-base-300 p-10">

        <div class="max-w-6xl mx-auto bg-base-100 rounded-xl shadow-lg p-8">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-semibold text-secondary">Users List</h2>
                <a href="../index.jsp" class="text-primary hover:underline">← Dashboard</a>
            </div>
            <div class="overflow-x-auto rounded-box border border-base-content/5 bg-base-100">
                <table class="table">
                    <thead>
                        <tr class="bg-base-200">
                            <th>Username</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${requestScope.users}">
                            <tr class="bg-base-100">
                                <td>${u.username}</td>
                                <td>${u.fullname}</td>
                                <td>${u.email}</td>
                                <td>${u.role}</td>
                                <td class="text-center">
                                    <a href="details.jsp?id=${u.id}" class="text-primary hover:underline text-sm">Details</a>
                                    <a href="edit.jsp?id=${u.id}" class="text-warning hover:underline text-sm">Edit</a>
                                    <a href="delete.jsp?id=${u.id}" class="text-error hover:underline text-sm">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="mt-6 text-center">
                <a href="create.jsp" class="btn btn-secondary">Add New User</a>
            </div>
        </div>

    </body>
</html>

