<%-- 
    Document   : delete
    Created on : Nov 10, 2025, 10:08:41 PM
    Author     : anhdaik
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Delete User</title>
        <jsp:include page="/static/css/styles.jsp"/>
    </head>
    <body class="bg-base-300 flex justify-center items-center h-screen">
        <div class="bg-base-100 shadow-lg rounded-xl p-8 text-center">
            <h2 class="text-xl font-semibold text-secondary mb-4">Confirm Delete</h2>
            <p>Are you sure you want to delete <strong>${requestScope.company.companyName}</strong>?</p>

            <form action="../../CompanyController" method="post" class="mt-6 space-x-3">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="id" value="${company.id}"/> 
                
                <button class="bg-error text-error-content px-4 py-2 rounded-lg hover:bg-red-700">Delete</button>
                <a href="index.jsp" class="text-primary hover:underline">Cancel</a>
            </form>
        </div>
    </body>
</html>
