<%-- 
    Document   : jobs
    Created on : Nov 10, 2025, 9:57:46 PM
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
        <title>Manage Jobs</title>
        <jsp:include page="/static/css/styles.jsp"/>
    </head>
    <body class="bg-base-300 p-10">

        <div class="max-w-5xl mx-auto bg-base-100 rounded-xl shadow-lg p-8">
            <h2 class="text-2xl font-semibold text-secondary mb-6 flex justify-between">
                Manage Jobs
                <a href="index.jsp" class="text-primary text-sm hover:underline">← Back</a>
            </h2>

            <div class="space-y-3 mb-8">
                <c:forEach var="entry" items="${applicationScope.jobs}">
                    <div class="flex justify-between items-center bg-gray-50 p-3 rounded-lg hover:bg-gray-100">
                        <div>
                            <p class="font-medium text-gray-700">${entry.value.title}</p>
                            <p class="text-sm text-gray-500">${entry.value.status}</p>
                        </div>
                        <div class="flex space-x-2">
                            <form action="JobController" method="post">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="jobId" value="${entry.key}"/>
                                <button class="text-red-500 hover:text-red-700 text-sm">Delete</button>
                            </form>
                            <c:if test="${entry.value.status ne 'Approved'}">
                                <form action="JobController" method="post">
                                    <input type="hidden" name="action" value="approve"/>
                                    <input type="hidden" name="jobId" value="${entry.key}"/>
                                    <button class="text-green-600 hover:text-green-700 text-sm">Approve</button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <h3 class="text-lg font-semibold mb-2">Add New Job</h3>
            <form method="post" action="JobController" class="grid grid-cols-2 gap-4">
                <input type="hidden" name="action" value="create"/>
                <input name="title" placeholder="Job Title" class="input w-full col-span-2"/>
                <textarea name="description" rows="3" placeholder="Job Description" class="textarea w-full col-span-2"></textarea>
                <input name="companyId" placeholder="Company ID" class="input w-full col-span-2 md:col-span-1"/>
                <input name="location" placeholder="Location" class="input w-full col-span-2 md:col-span-1"/>
                <button class="col-span-2 btn btn-secondary">Add Job</button>
            </form>
        </div>

    </body>
</html>

