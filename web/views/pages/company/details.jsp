<%-- 
    Document   : company-detail.jsp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/static/css/styles.jsp"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <title>
            <c:choose>
                <c:when test="${not empty company}">
                    Company Details - <c:out value="${company.name}"/>
                </c:when>
                <c:otherwise>
                    Company Not Found
                </c:otherwise>
            </c:choose>
        </title>
    </head>

    <body> 

        <jsp:include page="/views/components/header.jsp"/>

        <main class="w-full min-h-screen">

            <c:choose>
                <c:when test="${not empty company}">
                    <section class="relative block h-[500px] w-full">
                        <div class="absolute top-0 w-full h-full bg-center bg-cover" 
                             style="background-image: url('https://anhdaik.vercel.app/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fcover.1a753d17.png&w=1920&q=75');">
                            <span id="blackOverlay" class="w-full h-full absolute opacity-50 bg-black"></span>
                        </div>
                        <div class="top-auto bottom-0 left-0 right-0 w-full absolute pointer-events-none overflow-hidden h-70-px" style="transform: translateZ(0px)">
                            <svg class="absolute bottom-0 overflow-hidden" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none" version="1.1" viewBox="0 0 2560 100" x="0" y="0">
                            <polygon class="text-base-200 fill-current" points="2560 0 2560 100 0 100"></polygon>
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
                                                <img alt="${company.name} Logo" 
                                                     src="${not empty company.logo ? company.logo : 'https://via.placeholder.com/150'}" 
                                                     class="w-full h-full object-cover rounded-full shadow-xl">
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-4/12 px-4 lg:order-3 lg:text-right lg:self-center">
                                            <div class="py-6 px-3 mt-32 sm:mt-0">
                                                <button class="btn btn-secondary" type="button">
                                                    Follow Company
                                                </button>
                                            </div>
                                        </div>
                                        <div class="w-full lg:w-4/12 px-4 lg:order-1">
                                            <div class="flex justify-center py-4 lg:pt-4 pt-8">
                                                <%-- Dữ liệu động: Stats --%>
                                                <div class="mr-4 p-3 text-center">
                                                    <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">
                                                        <fmt:formatNumber value="${company.jobCount}"/>
                                                    </span>
                                                    <span class="text-sm text-blueGray-400">Jobs</span>
                                                </div>
                                                <div class="mr-4 p-3 text-center">
                                                    <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">
                                                        <fmt:formatNumber value="${company.reviewCount}"/>k
                                                    </span>
                                                    <span class="text-sm text-blueGray-400">Reviews</span>
                                                </div>
                                                <div class="lg:mr-4 p-3 text-center">
                                                    <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">
                                                        <fmt:formatNumber value="${company.avgSalary}" maxFractionDigits="1"/>k
                                                    </span>
                                                    <span class="text-sm text-blueGray-400">Salaries</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="text-center mt-12">
                                        <h3 class="text-4xl font-semibold leading-normal mb-2 text-blueGray-700 mb-2">
                                            <c:out value="${company.name}"/>
                                        </h3>
                                        <div class="text-sm leading-normal mt-0 mb-2 text-blueGray-400 font-bold uppercase">
                                            <i class="fas fa-map-marker-alt mr-2 text-lg text-blueGray-400"></i>
                                            <c:out value="${company.location}"/>
                                        </div>
                                    </div>

                                    <div class="mt-10 py-10 border-t border-blueGray-200 text-center">
                                        <div class="flex flex-wrap justify-center">
                                            <div class="w-full lg:w-9/12 px-4">
                                                <p class="mb-4 text-lg leading-relaxed text-blueGray-700">
                                                    <c:out value="${company.description}" default="No description provided."/>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="container mx-auto px-4">
                            <div class="bg-base-100 p-4 rounded-box shadow-sm flex flex-col gap-6">
                                <div role="tablist" class="tabs tabs-border">
                                    <a role="tab" class="tab tab-active about">About Company</a>
                                    <a role="tab" class="tab people">People</a>
                                    <a role="tab" class="tab overview">Overview</a>
                                    <a role="tab" class="tab jobs">Jobs</a>
                                </div>

                                <p class="prose max-w-none p-4" id="content"></p>
                            </div>
                        </div>

                    </section>
                </c:when>

                <c:otherwise>
                    <div class="relative py-16 bg-base-200 w-full min-h-[50vh] flex items-center justify-center">
                        <div class="text-center">
                            <i class="fas fa-search fa-4x text-gray-300 mb-4"></i>
                            <h3 class="text-3xl font-semibold text-gray-700 mb-2">
                                Company Not Found
                            </h3>
                            <p class="text-gray-500 mb-6">
                                The company you are looking for might have been removed or does not exist.
                            </p>
                            <a href="${pageContext.request.contextPath}/companies" 
                               class="btn btn-primary">
                                Back to Companies List
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <jsp:include page="/views/components/footer.jsp"/>

        <script>
            let tabs = document.querySelectorAll("a.tab");
            let activeTabs = document.querySelectorAll("a.tab.tab-active");
            let contentTab = document.querySelector("#content");

            let contents = [
                {
                    name: "about",
                    // Lấy mô tả từ ${company.description}
                    contents: `<c:out value="${fn:escapeXml(company.description)}" default="No company description available."/>`
                }, {
                    name: "people",
                    contents: "People information is not available at this moment."
                }, {
                    name: "overview",
                    contents: "Overview information is not available at this moment."
                }, {
                    name: "jobs",
                    // Thêm link để xem các công việc của công ty này
                    contents: `
                        <input type="radio" name="company_tabs" role="tab" class="tab" aria-label="Jobs (${company.jobCount})"/>
        <div role="tabpanel" class="tab-content bg-base-100 border-base-300 rounded-box p-6">
            <h4 class="text-2xl font-semibold mb-6">Open Positions at ${company.name}</h4>
            
            <div class="flex flex-col gap-4">
            <c:choose>
                <c:when test="${not empty companyJobs}">
                        
                    <c:forEach var="job" items="${companyJobs}">
                            
                            <a href="${pageContext.request.contextPath}/jobDetail?id=${job.id}" 
                               class="block p-4 bg-base-200 rounded-lg shadow-sm hover:shadow-md transition-shadow">
                                
                                <div class="flex justify-between items-center">
                                    <h5 class="text-xl font-bold text-secondary">${job.title}</h5>
                                    <span class="text-sm text-gray-500">
                        ${-job.daysAgo} days left
                                    </span>
                                </div>
                                <p class="text-gray-600 mt-1">${job.location}</p>
                                <p class="text-lg font-medium text-blue-600 mt-2">
                        <c:out value="$ ${job.salary}" default="Negotiable"/>
                                </p>
                                <div class="flex gap-2 mt-2">
                        <c:forEach var="skill" items="${fn:split(job.skills, ',')}">
                                        <span class="badge badge-outline">${fn:trim(skill)}</span>
                        </c:forEach>
                                </div>
                            </a>
                    </c:forEach>
                </c:when>
                    
                <c:otherwise>
                        <p class="text-gray-500">There are currently no open positions at ${company.name}.</p>
                </c:otherwise>
            </c:choose>
            </div>
        </div>
                    `
                },
            ];

            let setContent = () => {
                activeTab = document.querySelector("a.tab.tab-active");
                contents.forEach((content) => {
                    if (activeTab.classList.contains(content.name)) {
                        contentTab.innerHTML = content.contents;
                    }
                })
            }

            setContent();

            tabs.forEach((tab) => {
                tab.addEventListener('click', () => {
                    activeTabs.forEach((activeTab) => {
                        activeTab.classList.remove("tab-active");
                    })
                    tab.classList.add("tab-active");
                    activeTabs = document.querySelectorAll("a.tab.tab-active");
                    setContent();
                })
            });
        </script>

    </body>
</html>