<%-- 
    Document   : settings
    Created on : Nov 7, 2025, 5:09:33 PM
    Author     : anhdaik
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--<c:if test="${sessionScope.role ne 'Recruiter'}">
    <c:redirect url="/login"/>
</c:if>--%>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Company Settings</title>
        <jsp:include page="/static/css/styles.jsp"/>
    </head>
    <body class="bg-base-300 min-h-screen flex items-center justify-center">

        <div class="max-w-xl w-full bg-base-100 shadow-lg rounded-2xl p-8">
            <h2 class="text-2xl font-semibold text-secondary mb-6 text-center">Company Settings</h2>

            <form action="${pageContext.request.contextPath}/company-settings" method="post" class="space-y-5">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Company Name</label>
                    <input type="text" name="name" value="${sessionScope.companyName}"
                           class="w-full input"/>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                    <input type="email" name="email" value="${sessionScope.email}"
                           class="w-full input"/>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Website</label>
                    <input type="text" name="website" value="${sessionScope.website}"
                           class="w-full input"/>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                    <input type="text" name="address" value="${sessionScope.address}"
                           class="w-full input"/>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                    <textarea class="textarea w-full" placeholder="Bio" name="description"></textarea>
                </div>

                <button type="submit"
                        class="w-full btn btn-secondary">Save
                </button>
            </form>

            <div class="mt-6 text-center">
                <a href="${pageContext.request.contextPath}/"
                   class="text-primary hover:underline text-sm">← Back to Home</a>
            </div>
        </div>

    </body>
</html>
