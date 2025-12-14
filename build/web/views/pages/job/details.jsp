<%--
    Document   : details (Job Details)
    Updated on : Nov 11, 2025
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/static/css/styles.jsp"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <title>
            <c:choose>
                <c:when test="${not empty job}">
                    Job Details - <c:out value="${job.title}"/>
                </c:when>
                <c:otherwise>
                    Job Not Found
                </c:otherwise>
            </c:choose>
        </title>
    </head>

    <body> 
        <jsp:include page="/views/components/header.jsp"/>

        <main class="w-full min-h-screen">

            <section class="relative block h-[300px] sm:h-[400px] w-full">
                <div class="absolute top-0 w-full h-full bg-center bg-cover" 
                     style="background-image: url('https://picsum.photos/1600/600?random=1');">
                    <span id="blackOverlay" class="w-full h-full absolute opacity-60 bg-black"></span>
                </div>
                <div class="top-auto bottom-0 left-0 right-0 w-full absolute pointer-events-none overflow-hidden h-70-px" style="transform: translateZ(0px)">
                    <svg class="absolute bottom-0 overflow-hidden" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none" version="1.1" viewBox="0 0 2560 100" x="0" y="0">
                    <polygon class="text-base-200 fill-current" points="2560 0 2560 100 0 100"></polygon>
                    </svg>
                </div>
            </section>

            <section class="relative py-16 bg-base-200 w-full">
                <div class="container mx-auto px-4">

                    <c:choose>
                        <c:when test="${not empty job}">
                            <c:set var="logoUrl" value="${not empty job.companyLogo ? job.companyLogo : 'https://via.placeholder.com/150?text=No+Logo'}" />

                            <div class="relative flex flex-col min-w-0 break-words bg-base-100 w-full mb-6 shadow-xl rounded-lg -mt-64">

                                <div class="px-6 py-8 flex flex-col sm:flex-row items-center">
                                    <img src="${logoUrl}" alt="${job.companyName} Logo" 
                                         class="h-24 w-24 rounded-lg object-contain shadow-md -mt-16 sm:mt-0 mb-4 sm:mb-0"/>
                                    <div class="sm:ml-6 text-center sm:text-left">
                                        <h2 class="text-3xl font-semibold text-base-content">
                                            <c:out value="${job.companyName}"/>
                                        </h2>
                                        <div class="text-lg mt-1 text-gray-500 font-bold">
                                            <i class="fas fa-map-marker-alt mr-2 text-gray-400"></i>
                                            <c:out value="${job.location}"/>
                                        </div>
                                    </div>
                                </div>

                                <div class="px-6 py-6 border-t border-gray-200 flex flex-col sm:flex-row justify-between sm:items-center">
                                    <h1 class="text-4xl font-semibold leading-normal mb-4 sm:mb-0 text-base-content">
                                        <c:out value="${job.title}"/>
                                    </h1>
                                    <a href="${pageContext.request.contextPath}/apply?id=${job.id}" 
                                       class="btn btn-secondary btn-lg w-full sm:w-auto">
                                        Apply Now
                                    </a>
                                </div>

                                <div class="px-6 py-6 border-t border-gray-200 bg-base-200/30">
                                    <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                                        <div class="text-center md:text-left">
                                            <h5 class="text-sm font-semibold text-gray-500 uppercase">Salary</h5>
                                            <p class="text-lg font-bold text-blue-600">
                                                <i class="fas fa-dollar-sign mr-1"></i>
                                                <c:out value="${not empty job.salary ? job.salary : 'Negotiable'}" />
                                            </p>
                                        </div>
                                        <div class="text-center md:text-left">
                                            <h5 class="text-sm font-semibold text-gray-500 uppercase">Category</h5>
                                            <p class="text-lg font-medium text-base-content">
                                                <i class="fas fa-tags mr-1"></i>
                                                <c:out value="${job.categoryName}" />
                                            </p>
                                        </div>
                                        <div class="text-center md:text-left">
                                            <h5 class="text-sm font-semibold text-gray-500 uppercase">Status</h5>

                                            <c:choose>
                                                <c:when test="${job.daysAgo >= 0}">
                                                    <p class="text-lg font-bold text-red-600">
                                                        <i class="fas fa-times-circle mr-1"></i>
                                                        Expired
                                                    </p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="text-lg font-medium text-green-600">
                                                        <i class="fas fa-check-circle mr-1"></i>
                                                        ${-job.daysAgo} days left
                                                    </p>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="text-center md:text-left">
                                            <h5 class="text-sm font-semibold text-gray-500 uppercase">Deadline</h5>
                                            <p class="text-lg font-medium text-base-content">
                                                <i class="fas fa-calendar-times mr-1"></i>
                                                <fmt:formatDate value="${job.endDate}" pattern="dd-MM-yyyy" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="px-6 py-10 border-t border-gray-200">
                                    <h4 class="text-2xl font-semibold mb-6 text-base-content">Job Details</h4>
                                    <div class="flex flex-wrap justify-center">
                                        <div class="w-full lg:w-11/12 prose max-w-none text-gray-700">
                                            <c:out value="${job.description}" escapeXml="false" 
                                                   default="<p>No detailed description available for this job.</p>"/>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="relative flex flex-col min-w-0 break-words bg-base-100 w-full mb-6 shadow-xl rounded-lg -mt-64">
                                <div class="px-6 py-24 text-center">
                                    <i class="fas fa-search fa-3x text-gray-300 mb-4"></i>
                                    <h3 class="text-3xl font-semibold text-gray-700 mb-2">
                                        Job Not Found
                                    </h3>
                                    <p class="text-gray-500 mb-6">
                                        The job you are looking for might have been removed or does not exist.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/search" 
                                       class="btn btn-primary">
                                        Back to Search
                                    </a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </div>
            </section>
        </main>

        <jsp:include page="/views/components/footer.jsp"/>
    </body>
</html>