
<%-- 
    Document   : index
    Created on : Sep 30, 2025, 1:10:11 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/static/css/styles.jsp"/>
        <title>Search Jobs - One1</title>
    </head>
    <body>
        <jsp:include page="/views/components/header.jsp"/>

        <section class="w-full min-h-screen flex flex-col justify-center items-center max-w-7xl mx-auto py-36">
            <!-- Search Form -->
            <form action="${pageContext.request.contextPath}/search" 
                  method="GET" 
                  class="flex items-center flex-col gap-8 md:mb-8">

                <h1 class="font-bold text-3xl">Discover the Best Job</h1>

                <div class="join">
                    <div>
                        <input class="input join-item min-w-[300px] md:min-w-md" 
                               placeholder="Job title or keywords" 
                               name="keyword"
                               value="${not empty keyword ? keyword : ''}"/>
                    </div>
                    <div class="indicator">
                        <button type="submit" class="btn join-item">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                            <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
                            </svg>
                            Search
                        </button>
                    </div>
                </div>
            </form>

            <!-- Filters -->
            <div class="max-w-7xl mx-auto flex flex-col">
                <div class="max-w-md mx-auto flex gap-2 items-center flex-wrap my-4">
                    <input class="btn" type="radio" name="options" aria-label="Work Language" />
                    <input class="btn" type="radio" name="options" aria-label="Publication Date" />
                    <input class="btn" type="radio" name="options" aria-label="Education Level" />
                    <input class="btn" type="radio" name="options" aria-label="Job type" />
                    <input class="btn" type="radio" name="options" aria-label="Distance" />
                    <input class="btn" type="radio" name="options" aria-label="Salary" />
                    <input class="btn" type="radio" name="options" aria-label="Work modes" />
                    <input class="btn" type="radio" name="options" aria-label="Boss's beauty" />
                </div>
            </div>

            <!-- Job List -->
            <div class="flex-1 mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-4">
                <c:choose>
                    <c:when test="${not empty jobs}">
                        <c:forEach var="job" items="${jobs}">
                            <jsp:include page="/views/components/jobCard.jsp">
                                <jsp:param name="link" value="${pageContext.request.contextPath}/jobDetail?id=${job.id}"/>
                                <jsp:param name="src" value="${not empty job.companyLogo ? job.companyLogo : 'https://via.placeholder.com/150'}"/>
                                <jsp:param name="company" value="${job.companyName}"/>
                                <jsp:param name="title" value="${job.title}"/>
                                <jsp:param name="skills" value="${job.skills}"/>
                                <jsp:param name="location" value="${job.location}"/>
                                <jsp:param name="salary" value="${job.salary}"/>
                                <jsp:param name="daysAgo" value="${job.daysAgo}"/>
                                <jsp:param name="className" value="w-md" />
                            </jsp:include>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-span-full text-center py-16">
                            <svg class="w-20 h-20 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                            <h3 class="text-xl font-semibold text-gray-700 mb-2">No Jobs Found</h3>
                            <p class="text-gray-500">
                                <c:choose>
                                    <c:when test="${not empty keyword}">
                                        Try different keywords or clear the search
                                    </c:when>
                                    <c:otherwise>
                                        No jobs available at the moment
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <c:if test="${not empty keyword}">
                                <a href="${pageContext.request.contextPath}/search" 
                                   class="inline-block mt-4 px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
                                    View All Jobs
                                </a>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <jsp:include page="/views/components/footer.jsp"/>
</body>
</html>