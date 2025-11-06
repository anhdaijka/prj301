<%-- 
    Document   : index
    Created on : Sep 30, 2025, 1:10:11 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (request.getAttribute("categories") == null) {
        response.sendRedirect(request.getContextPath() + "/category");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/static/css/styles.jsp"/>
        <title>One1 HomePage - Your skills your deal</title>
    </head>

    <jsp:include page="/views/components/header.jsp"/>

    <jsp:include page="/views/pages/home/hero.jsp"/>

    <jsp:include page="/views/pages/home/popularCat.jsp"/>

    <jsp:include page="/views/pages/home/newestJobs.jsp"/>

    <jsp:include page="/views/pages/home/how.jsp"/>

    <jsp:include page="/views/pages/home/topCompanies.jsp"/>

    <jsp:include page="/views/pages/home/conclusion.jsp"/>

    <jsp:include page="/views/components/footer.jsp"/>

</html>