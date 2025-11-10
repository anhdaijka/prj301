<%-- 
    Document   : company
    Created on : Nov 7, 2025, 5:08:26 PM
    Author     : anhdaik
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--<c:if test="${sessionScope.role ne 'Admin'}">
  <c:redirect url="/Login" />
</c:if>--%>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Companies</title>
        <jsp:include page="/static/css/styles.jsp"/>
    </head>
    <body class="bg-base-300 p-10">

        <div class="max-w-5xl mx-auto bg-base-100 rounded-xl shadow-lg p-8">
            <h2 class="text-2xl font-semibold text-secondary mb-6 flex justify-between">
                Manage Companies
                <a href="index.jsp" class="text-primary text-sm hover:underline">← Back</a>
            </h2>

            <div class="space-y-3 mb-8">
                <c:forEach var="entry" items="${applicationScope.companies}">
                    <div class="flex justify-between items-center bg-gray-50 p-3 rounded-lg hover:bg-gray-100">
                        <div>
                            <p class="font-medium text-gray-700">${entry.key}</p>
                            <p class="text-sm text-gray-500">${entry.value.email}</p>
                        </div>
                        <form action="CompanyController" method="post">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="company" value="${entry.key}"/>
                            <button class="text-red-500 hover:text-red-700 text-sm">Delete</button>
                        </form>
                    </div>
                </c:forEach>
            </div>

            <h3 class="text-lg font-semibold mb-2">Add New Company</h3>
            <form method="post" action="CompanyController" class="grid grid-cols-2 gap-4">
                <input type="hidden" name="action" value="create"/>
                <input name="name" placeholder="Company Name" class="input w-full"/>
                <input name="email" placeholder="Email" class="input w-full"/>
                <input name="address" placeholder="Address" class="input w-full col-span-2"/>
                <button class="col-span-2 btn btn-secondary">Add Company</button>
            </form>
        </div>

    </body>
</html>

