<%-- 
    Document   : edit
    Created on : Nov 10, 2025, 10:08:14 PM
    Author     : anhdaik
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit User</title>
        <jsp:include page="/static/css/styles.jsp"/>

    </head>
    <body class="bg-base-300 flex justify-center py-10">
        <form action="../../CompanyController" method="post" class="bg-base-100 rounded-xl shadow-lg p-8 w-full max-w-lg space-y-4 flex flex-col">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="id" value="${requestScope.company.id}"/>

            <h2 class="text-2xl font-semibold text-secondary mb-4">Edit Company</h2>

            <input type="text" name="name" value="${company.companyName}" placeholder="Company Name"
                   class="w-full input"/>
            <input type="email" name="email" value="${company.email}" placeholder="Email"
                   class="w-full input"/>
            <input type="text" name="phone" value="${company.phone}" placeholder="Phone"
                   class="w-full input"/>
            <input type="text" name="address" value="${company.address}" placeholder="Address"
                   class="w-full input"/>
            <select name="role" class="w-full select">
                <option ${user.role == 'Job seeker' ? 'selected' : ''}>Job seeker</option>
                <option ${user.role == 'Recruiter' ? 'selected' : ''}>Recruiter</option>
                <option ${user.role == 'Admin' ? 'selected' : ''}>Admin</option>
            </select>

            <button class="w-full btn btn-secondary mt-auto
                    ">Save Changes</button>
            <div class="text-center">
                <a href="index.jsp" class="text-primary hover:underline text-sm">Cancel</a>
            </div>
        </form>
    </body>
</html>

