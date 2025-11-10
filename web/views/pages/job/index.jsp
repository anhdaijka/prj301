<%-- 
    Document   : index
    Created on : Sep 30, 2025, 1:10:11 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
    if (request.getAttribute("jobs") == null) {
        response.sendRedirect(request.getContextPath() + "/search");
         return;
    }
%>

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

<<<<<<< HEAD
                <h1 class="font-bold text-3xl">Discover the Best Job</h1>

                <div class="join">
                    <div>
                        <input class="input join-item min-w-[300px] md:min-w-md" 
                               placeholder="Job title or keywords" 
                               name="keyword"
                               value="${not empty keyword ? keyword : ""}"/>
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
            <div class="flex-1 mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-4 w-full">
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
        </section>
=======
    <section class="w-full min-h-screen flex flex-col items-center justify-center max-w-7xl mx-auto">
        <section class="relative block h-[500px] w-full">
            <div class="absolute top-0 w-full h-full bg-center bg-cover" style="
                 background-image: url('https://anhdaik.vercel.app/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fcover.1a753d17.png&w=1920&q=75');
                 ">
                <span id="blackOverlay" class="w-full h-full absolute opacity-50 bg-black"></span>
            </div>
            <div class="top-auto bottom-0 left-0 right-0 w-full absolute pointer-events-none overflow-hidden h-70-px" style="transform: translateZ(0px)">
                <svg class="absolute bottom-0 overflow-hidden" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none" version="1.1" viewBox="0 0 2560 100" x="0" y="0">
                <polygon class="text-blueGray-200 fill-current" points="2560 0 2560 100 0 100"></polygon>
                </svg>
            </div>
        </section>
        <section class="relative py-16 bg-base-200">
            <div class="container mx-auto px-4">
                <div class="relative flex flex-col min-w-0 break-words bg-base-100 w-full mb-6 shadow-xl rounded-lg -mt-64">
                    <div class="px-6">
                        <div class="flex flex-wrap justify-center">
                            <div class="w-full lg:w-3/12 px-4 lg:order-2 avatar flex items-center justify-center">
                                <div class="relative rounded-full size-48 -top-1/2">
                                    <img alt="..." src="https://media.daily.dev/image/upload/s--wzOhK88f--/f_auto/v1724228753/avatars/avatar_nyNDZ2Trf7sk4FgOodgWN" 
                                       >
                                </div>
                            </div>
                            <div class="w-full lg:w-4/12 px-4 lg:order-3 lg:text-right lg:self-center">
                                <div class="py-6 px-3 mt-32 sm:mt-0">
                                    <button class="btn btn-secondary" type="button">
                                        Connect
                                    </button>
                                </div>
                            </div>
                            <div class="w-full lg:w-4/12 px-4 lg:order-1">
                                <div class="flex justify-center py-4 lg:pt-4 pt-8">
                                    <div class="mr-4 p-3 text-center">
                                        <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">22</span><span class="text-sm text-blueGray-400">Friends</span>
                                    </div>
                                    <div class="mr-4 p-3 text-center">
                                        <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">10</span><span class="text-sm text-blueGray-400">Photos</span>
                                    </div>
                                    <div class="lg:mr-4 p-3 text-center">
                                        <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">89</span><span class="text-sm text-blueGray-400">Comments</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-center mt-12">
                            <h3 class="text-4xl font-semibold leading-normal mb-2 text-blueGray-700 mb-2">
                                BMW
                            </h3>
                            <div class="text-sm leading-normal mt-0 mb-2 text-blueGray-400 font-bold uppercase">
                                <i class="fas fa-map-marker-alt mr-2 text-lg text-blueGray-400"></i>
                                Los Angeles, California
                            </div>
                            <div class="mb-2 text-blueGray-600 mt-10">
                                <i class="fas fa-briefcase mr-2 text-lg text-blueGray-400"></i>Solution Manager - Creative Tim Officer
                            </div>
                            <div class="mb-2 text-blueGray-600">
                                <i class="fas fa-university mr-2 text-lg text-blueGray-400"></i>University of Computer Science
                            </div>
                        </div>
                        <div class="mt-10 py-10 border-t border-blueGray-200 text-center">
                            <div class="flex flex-wrap justify-center">
                                <div class="w-full lg:w-9/12 px-4">
                                    <p class="mb-4 text-lg leading-relaxed text-blueGray-700">
                                        An artist of considerable range, Jenna the name taken by
                                        Melbourne-raised, Brooklyn-based Nick Murphy writes,
                                        performs and records all of his own music, giving it a
                                        warm, intimate feel with a solid groove structure. An
                                        artist of considerable range.
                                    </p>
                                    <a href="#pablo" class="font-normal text-pink-500">Show more</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <footer class="relative bg-blueGray-200 pt-8 pb-6 mt-8">
                <div class="container mx-auto px-4">
                    <div class="flex flex-wrap items-center md:justify-between justify-center">
                        <div class="w-full md:w-6/12 px-4 mx-auto text-center">
                            <div class="text-sm text-blueGray-500 font-semibold py-1">
                                Made with <a href="https://www.creative-tim.com/product/notus-js" class="text-blueGray-500 hover:text-gray-800" target="_blank">Notus JS</a> by <a href="https://www.creative-tim.com" class="text-blueGray-500 hover:text-blueGray-800" target="_blank"> Creative Tim</a>.
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
        </section>
    </section>
>>>>>>> 210c460d627956b134b9646d751e1131410b82e9

        <jsp:include page="/views/components/footer.jsp"/>
    </body>
</html>