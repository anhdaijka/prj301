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
        <form action="../../JobController" method="post" class="bg-base-100 rounded-xl shadow-lg p-8 w-full max-w-lg space-y-4 flex flex-col">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="id" value="${requestScope.job.id}"/>

            <h2 class="text-2xl font-semibold text-secondary mb-4">Edit Job</h2>

            <input type="text" name="title" value="${job.title}" placeholder="Title"
                   class="w-full input"/>
            <input type="text" class="input w-full" value="${job.description}" name="description" placeholder="Decription" />
            <input type="text" name="location" value="${job.location}" placeholder="Phone"
                   class="w-full input"/>
            <select name="status" class="w-full select">
                <option ${job.status == 'pending' ? 'selected' : ''}>Pending</option>
                <option ${job.status == 'approved' ? 'selected' : ''}>Approved</option>
                <option ${job.status == 'rejected' ? 'selected' : ''}>Rejected</option>
            </select>

            <button class="w-full btn btn-secondary mt-auto
                    ">Save Changes</button>
            <div class="text-center">
                <a href="index.jsp" class="text-primary hover:underline text-sm">Cancel</a>
            </div>
        </form>
    </body>
</html>

