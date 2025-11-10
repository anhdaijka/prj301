<%-- 
    Document   : admin
    Created on : Nov 7, 2025, 5:08:33 PM
    Author     : anhdaik
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--<c:if test="${sessionScope.role ne 'Admin'}">
    <c:redirect url="/login" />
</c:if>--%>

<html lang="en">
    <head>
        <meta charset="UTF-8">
            <title>Admin Dashboard</title>
            <jsp:include page="/static/css/styles.jsp"/>
    </head>

    <body class="bg-gray-100 min-h-screen flex flex-col items-center p-10">
        <h1 class="text-3xl font-bold text-gray-800 mb-8">Admin Dashboard</h1>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 w-full max-w-5xl">
            <a href="users" class="bg-white shadow-lg hover:shadow-xl transition rounded-2xl p-8 flex flex-col items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-blue-600 mb-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5V8H2v12h5m10 0v-6H7v6" />
                </svg>
                <h3 class="text-lg font-semibold text-gray-700">Manage Users</h3>
            </a>

            <a href="companies" class="bg-white shadow-lg hover:shadow-xl transition rounded-2xl p-8 flex flex-col items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-green-600 mb-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 10h16M4 14h16M4 18h16" />
                </svg>
                <h3 class="text-lg font-semibold text-gray-700">Manage Companies</h3>
            </a>

            <a href="jobs" class="bg-white shadow-lg hover:shadow-xl transition rounded-2xl p-8 flex flex-col items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-purple-600 mb-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c1.657 0 3-1.343 3-3S13.657 2 12 2 9 3.343 9 5s1.343 3 3 3zM4 22v-2c0-1.104.896-2 2-2h12a2 2 0 012 2v2" />
                </svg>
                <h3 class="text-lg font-semibold text-gray-700">Manage Jobs</h3>
            </a>
        </div>
    </body>
</html>
