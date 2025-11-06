<%-- 
    Document   : popular
    Created on : Oct 27, 2025, 2:45:17 PM
    Author     : anhdaik
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="min-h-[50vh] w-full py-12 relative">
    <jsp:include page="/views/components/heading.jsp">
        <jsp:param name="title" value="Top Companies"/>
        <jsp:param name="sub" value="The last job offers Upload"/>
    </jsp:include>
    
    <a href="${pageContext.request.contextPath}/companies" 
       class="absolute right-8 top-24 hover:underline text-secondary"> 
        More &gt;
    </a>
    
    <div class="flex items-center justify-center">
        <div class="grid grid-cols-1 xl:grid-cols-3 gap-12 lg:gap-6">
            <c:forEach var="company" items="${requestScope.topCompanies}">
                <jsp:include page="/views/components/comCard.jsp">
                    <jsp:param name="link" value="#"/>
                    <jsp:param name="src" value="${company.logo}"/>
                    <jsp:param name="title" value="${company.name}"/>
                    <jsp:param name="categories" value="${company.skills}"/>
                    <jsp:param name="location" value="${company.location}"/>
                    <jsp:param name="bio" value="${company.description}"/>
                    <jsp:param name="stars" value="${company.rating}"/>
                    <jsp:param name="jobCount" value="${company.jobCount}"/>
                    <jsp:param name="reviewCount" value="${company.reviewCount}"/>
                    <jsp:param name="avgSalary" value="${company.avgSalary}"/>
                </jsp:include>
            </c:forEach>
        </div>
    </div>
    
    <!-- Empty State -->
    <c:if test="${empty requestScope.topCompanies}">
        <div class="text-center py-16">
            <p class="text-gray-500 text-lg">No companies available at the moment.</p>
        </div>
    </c:if>
</div>