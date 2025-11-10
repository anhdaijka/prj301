<%-- 
    Document   : settings
    Created on : Nov 7, 2025, 5:09:43 PM
    Author     : anhdaik
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--<c:if test="${sessionScope.role ne 'Job seeker'}">
    <c:redirect url="/login"/>
</c:if>--%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Settings</title>
    <jsp:include page="/static/css/styles.jsp"/>
</head>
<body class="bg-base-300 min-h-screen flex items-center justify-center">

<div class="max-w-xl w-full bg-white shadow-lg rounded-2xl p-8">
    <h2 class="text-2xl font-semibold text-secondary mb-6 text-center">User Settings</h2>

    <form action="${pageContext.request.contextPath}/user-settings" method="post" class="space-y-5">
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
            <input type="text" name="fullname" value="${sessionScope.fullname}"
                   class="w-full input"/>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
            <input type="email" name="email" value="${sessionScope.email}"
                   class="w-full input"/>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Phone</label>
            <input type="text" name="phone" value="${sessionScope.phone}"
                   class="w-full input"/>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">CV Link</label>
            <input type="text" name="cv" value="${sessionScope.cv}"
                   class="w-full input"/>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">New Password</label>
            <input type="password" name="password"
                   class="w-full input"/>
        </div>

        <button type="submit"
                class="w-full btn btn-secondary">Update
        </button>
    </form>

    <div class="mt-6 text-center">
        <a href="${pageContext.request.contextPath}/"
           class="text-primary hover:underline text-sm">← Back to Home</a>
    </div>
</div>

</body>
</html>

