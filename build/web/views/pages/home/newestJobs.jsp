<%-- 
    Document   : popular
    Created on : Oct 27, 2025, 2:45:17 PM
    Author     : anhdaik
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.*" %>
<div class="min-h-[50vh] w-full py-12 relative">
    <jsp:include page="/views/components/heading.jsp">
        <jsp:param name="title" value="Newest Jobs"/>
        <jsp:param name="sub" value="The last job offers Upload"/>
    </jsp:include>
    <a href="${pageContext.request.contextPath}/views/pages/job/index.jsp" class="absolute right-8 top-24 hover:underline text-secondary"> More ></a>

    <% List<String> items = Arrays.asList("ReactJS", "ExpressJS");
        pageContext.setAttribute("items", items); %>

    <div class=" grid place-content-center">

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="c" items="${requestScope.newestJobs}">
                <jsp:include page="/views/components/jobCard.jsp">
                    <jsp:param name="link" value="${pageContext.request.contextPath}/jobDetail?id=${job.id}"/>
                    <jsp:param name="src" value="${c.companyLogo}"/>
                    <jsp:param name="company" value="${c.companyName}"/>
                    <jsp:param name="title" value="${c.title}"/>
                    <jsp:param name="skills" value="${c.skills}"/>
                    <jsp:param name="location" value="${c.location}"/>
                    <jsp:param name="salary" value="${c.salary}"/>
                </jsp:include>
            </c:forEach>
        </div>
        
        <!-- Empty state -->
        <c:if test="${empty requestScope.newestJobs}">
            <div class="text-center py-12">
                <svg class="w-16 h-16 text-gray-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                          d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                </svg>
                <p class="text-gray-500 text-lg">No newest jobs available yet</p>
            </div>
        </c:if>
    </div>
</div>
