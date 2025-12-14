<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 
  Phần Servlet (ProfileController) đã kiểm tra đăng nhập, 
  nên chúng ta không cần <c:if> ở đây nữa.
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/static/css/styles.jsp"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        
        <%-- Khối C:SET này đã đúng --%>
        <c:set var="userObj" value="${sessionScope.user}" />
        <c:if test="${not empty userObj}">
            <c:set var="userName" value="${not empty userObj.fullName ? userObj.fullName : sessionScope.userName}" />
            <c:set var="userRole" value="${not empty userObj.roleName ? userObj.roleName : sessionScope.userRole}" />
            <c:set var="userAvatar" value="${userObj.avatarUrl}" />
            <c:set var="userEmail" value="${userObj.email}" />
        </c:if>

        <title>Profile - <c:out value="${userName}"/></title>
    </head>

    <body> 
        <jsp:include page="/views/components/header.jsp"/>

        <main class="w-full min-h-screen">
            <%-- Banner Section (Đã đúng) --%>
            <section class="relative block h-[300px] sm:h-[400px] w-full">
                <div class="absolute top-0 w-full h-full bg-center bg-cover" 
                     style="background-image: url('https://anhdaik.vercel.app/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fcover.1a753d17.png&w=1920&q=75');">
                    <span id="blackOverlay" class="w-full h-full absolute opacity-60 bg-black"></span>
                </div>
                <div class="top-auto bottom-0 left-0 right-0 w-full absolute pointer-events-none overflow-hidden h-70-px" style="transform: translateZ(0px)">
                    <svg class="absolute bottom-0 overflow-hidden" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none" version="1.1" viewBox="0 0 2560 100" x="0" y="0">
                        <polygon class="text-base-200 fill-current" points="2560 0 2560 100 0 100"></polygon>
                    </svg>
                </div>
            </section>

            <%-- Main Content Section --%>
            <section class="relative py-16 bg-base-200 w-full">
                <%-- SỬA LỖI LAYOUT: Bắt đầu 1 container CHUNG duy nhất ở đây --%>
                <div class="container mx-auto px-4">

                    <%-- Profile Card --%>
                    <div class="relative flex flex-col min-w-0 break-words bg-base-100 w-full mb-6 shadow-xl rounded-lg -mt-64">

                        <%-- Header Card --%>
                        <div class="px-6 py-8 flex flex-col sm:flex-row items-center">
                            <div class="avatar -mt-16 sm:mt-0 mb-4 sm:mb-0">
                                <div class="w-24 h-24 rounded-full shadow-md object-contain">
                                    <c:choose>
                                        <c:when test="${not empty userAvatar}">
                                            <img src="${userAvatar}" alt="${userName}" />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://ui-avatars.com/api/?name=${fn:replace(userName, ' ', '+')}&background=random&color=fff&size=128" 
                                                 alt="${userName}" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="sm:ml-6 text-center sm:text-left">
                                <h2 class="text-3xl font-semibold text-base-content"><c:out value="${userName}"/></h2>
                                <div class="text-lg mt-1 text-gray-500 font-bold">
                                    <i class="fas fa-map-marker-alt mr-2 text-gray-400"></i>
                                    <c:out value="${userObj.location}" default="No Location"/>
                                </div>
                            </div>
                        </div>

                       
                        <div class="px-6 py-6 border-t border-gray-200 flex flex-col sm:flex-row justify-between sm:items-center">
                            <h1 class="text-4xl font-semibold leading-normal mb-4 sm:mb-0 text-base-content">
                                <c:out value="${userRole}"/>
                            </h1>
                            <a href="#" class="btn btn-secondary btn-lg w-full sm:w-auto">
                                <i class="fas fa-edit mr-2"></i> Edit Profile
                            </a>
                        </div>

                        <%-- Stats Grid --%>
                        <div class="px-6 py-6 border-t border-gray-200 bg-base-200/30">
                            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                                <div class="text-center p-4 bg-base-100 rounded-lg shadow-sm">
                                    <h5 class="text-xs font-semibold text-gray-500 uppercase mb-2">Email</h5>
                                    <p class="text-sm font-medium text-base-content truncate" title="${userEmail}">
                                        <i class="fas fa-envelope mr-1"></i> <c:out value="${userEmail}" />
                                    </p>
                                </div>
                                <div class="text-center p-4 bg-base-100 rounded-lg shadow-sm">
                                    <h5 class="text-xs font-semibold text-gray-500 uppercase mb-2">Phone</h5>
                                    <p class="text-sm font-medium text-base-content">
                                        <i class="fas fa-phone mr-1"></i> <c:out value="${userObj.phone}" default="N/A" />
                                    </p>
                                </div>
                                <div class="text-center p-4 bg-base-100 rounded-lg shadow-sm">
                                    <h5 class="text-xs font-semibold text-gray-500 uppercase mb-2">Applications</h5>
                                    <p class="text-2xl font-bold text-primary">
                                        <i class="fas fa-file-alt mr-1"></i>
                                        <%-- Controller (lượt 65) gửi 'userApplications' --%>
                                        <c:out value="${fn:length(userApplications)}" default="0"/>
                                    </p>
                                </div>
                                <div class="text-center p-4 bg-base-100 rounded-lg shadow-sm">
                                    <h5 class="text-xs font-semibold text-gray-500 uppercase mb-2">Saved Jobs</h5>
                                    <p class="text-2xl font-bold text-secondary">
                                        <i class="fas fa-bookmark mr-1"></i>
                                        <c:out value="${fn:length(savedJobs)}" default="0"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div> 

                    
                    <div role="tablist" class="tabs tabs-lifted mt-8">
                        

                        <input type="radio" name="my_tabs" role="tab" class="tab" aria-label="My Applications" checked="checked" />
                        <div role="tabpanel" class="tab-content bg-base-100 border-base-300 rounded-b-box p-6">
                            <h4 class="text-2xl font-semibold mb-6">My Applications</h4>
                            <div class="flex flex-col gap-4">
                                <c:choose>
                                    <c:when test="${not empty userApplications}">
                                        <c:forEach var="app" items="${userApplications}">
                                            <a href="${pageContext.request.contextPath}/jobDetail?id=${app.jobId}" 
                                               class="block p-4 bg-base-200 rounded-lg shadow-sm hover:shadow-md transition-shadow">
                                                
                                                <div class="flex justify-between items-start">
                                                    <div class="flex items-center gap-4">
                                                        <div class="avatar">
                                                            <div class="w-12 h-12 rounded">
                                                                <img src="${not empty app.companyLogo ? app.companyLogo : 'https://via.placeholder.com/150'}" 
                                                                     alt="${app.companyName}" />
                                                            </div>
                                                        </div>
                                                        <div class="flex-1">
                                                            <h5 class="text-xl font-bold text-secondary">${app.jobTitle}</h5>
                                                            <p class="text-gray-600 mt-1"><i class="fas fa-building mr-1"></i> ${app.companyName}</p>
                                                            <p class="text-gray-600"><i class="fas fa-map-marker-alt mr-1"></i> ${app.jobLocation}</p>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="text-right flex-shrink-0">
                                                        <c:choose>
                                                            <c:when test="${app.status == 'Approved'}"><span class="badge badge-success">${app.status}</span></c:when>
                                                            <c:when test="${app.status == 'Rejected'}"><span class="badge badge-error">${app.status}</span></c:when>
                                                            <c:otherwise><span class="badge badge-warning">${app.status}</span></c:otherwise>
                                                        </c:choose>
                                                        <p class="text-sm text-gray-500 mt-2">
                                                            Applied: <fmt:formatDate value="${app.appliedAt}" pattern="MMM dd, yyyy"/>
                                                        </p>
                                                    </div>
                                                </div>
                                                
                                                <div class="flex gap-2 mt-3">
                                                    <c:forEach var="skill" items="${fn:split(app.jobSkills, ',')}">
                                                        <span class="badge badge-outline">${fn:trim(skill)}</span>
                                                    </c:forEach>
                                                </div>
                                            </a>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-12">
                                            <i class="fas fa-inbox text-6xl text-gray-300 mb-4"></i>
                                            <p class="text-gray-500 text-lg">You have 0 active applications.</p>
                                            <a href="${pageContext.request.contextPath}/search" class="btn btn-secondary mt-4">
                                                <i class="fas fa-search mr-2"></i> Browse Jobs
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div> 
                        <input type="radio" name="my_tabs" role="tab" class="tab" aria-label="Saved Jobs" />
                        <div role="tabpanel" class="tab-content bg-base-100 border-base-300 rounded-b-box p-6">
                            <h4 class="text-2xl font-semibold mb-6">Saved Jobs</h4>
                            <div class="flex flex-col gap-4">
                                <c:choose>
                                    <c:when test="${not empty savedJobs}">
                                        <c:forEach var="job" items="${savedJobs}">
                                            <a href="${pageContext.request.contextPath}/jobDetail?id=${job.id}" 
                                               class="block p-4 bg-base-200 rounded-lg shadow-sm hover:shadow-md transition-shadow">
                                                
                                                <div class="flex justify-between items-center">
                                                    <h5 class="text-xl font-bold text-secondary">${job.title}</h5>
                                                    <span class="text-sm text-gray-500">
                                                        <c:choose>
                                                            <c:when test="${job.daysAgo < 0}">
                                                                <span class="text-green-600">${-job.daysAgo} days left</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-red-500">Expired</span>
                                                            </c:otherwise>
                                                        </c:choose> 
                                                    </span>
                                                </div>
                                                
                                                <p class="text-gray-600 mt-1"><i class="fas fa-building mr-1"></i> ${job.companyName}</p>
                                                <p class="text-gray-600"><i class="fas fa-map-marker-alt mr-1"></i> ${job.location}</p>
                                                
                                                <p class="text-lg font-medium text-blue-600 mt-2">
                                                    <c:out value="${job.salary}" default="Negotiable"/>
                                                </p>
                                                
                                                <div class="flex gap-2 mt-2">
                                                    <c:forEach var="skill" items="${fn:split(job.skills, ',')}">
                                                        <span class="badge badge-outline">${fn:trim(skill)}</span>
                                                    </c:forEach>
                                                </div>
                                                
                                                <div class="mt-3 flex gap-2">
                                                    <button class="btn btn-sm btn-outline btn-error">
                                                        <i class="fas fa-bookmark mr-1"></i> Unsave
                                                    </button>
                                                    <button class="btn btn-sm btn-primary">
                                                        <i class="fas fa-paper-plane mr-1"></i> Apply Now
                                                    </button>
                                                </div>
                                            </a>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-12">
                                            <i class="fas fa-bookmark text-6xl text-gray-300 mb-4"></i>
                                            <p class="text-gray-500 text-lg">You have 0 saved jobs.</p>
                                            <a href="${pageContext.request.contextPath}/search" class="btn btn-secondary mt-4">
                                                <i class="fas fa-search mr-2"></i> Browse Jobs
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                    </div> 
                
                </div> 
            </section>
        </main>

        <jsp:include page="/views/components/footer.jsp"/>
    </body>
</html>