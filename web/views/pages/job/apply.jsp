<%--
    Document   : apply
    Created on : Nov 11, 2025
    Author     : FPT (Adapted by Gemini)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/static/css/styles.jsp"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        
        <title>
            <c:choose>
                <c:when test="${not empty job}">
                    Apply for - <c:out value="${job.title}"/>
                </c:when>
                <c:otherwise>
                    Application
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
                            <div class="relative flex flex-col min-w-0 break-words bg-base-100 w-full mb-6 shadow-xl rounded-lg -mt-64 max-w-3xl mx-auto">
                                <div class="px-6 py-10 md:px-12 md:py-12">
                                
                                    <%-- Form Header --%>
                                    <div class="text-center mb-8">
                                        <h1 class="text-3xl font-semibold">
                                            You are applying for:
                                        </h1>
                                        <h2 class="text-2xl font-medium text-secondary mt-1">
                                            <c:out value="${job.title}"/>
                                        </h2>
                                        <p class="text-gray-500 mt-1">
                                            at <c:out value="${job.companyName}"/>
                                        </p>
                                    </div>

                                    <form action="${pageContext.request.contextPath}/apply" method="POST" class="space-y-6">
                                       
                                        <input type="hidden" name="jobId" value="<c:out value='${job.id}'/>" />

                                        <div class="form-control w-full">
                                            <label class="label" for="cvSnapshot">
                                                <span class="label-text font-semibold text-base">CV Snapshot URL</span>
                                            </label>
                                            <input type="url" id="cvSnapshot" name="cvSnapshot" 
                                                   placeholder="https://your-online-cv.com/..." 
                                                   class="input input-bordered w-full" 
                                                   required />
                                            <label class="label">
                                                <span class="label-text-alt">Provide a public link to your CV (e.g., Google Drive, TopCV, etc.)</span>
                                            </label>
                                        </div>

                                        <div class="form-control w-full">
                                            <label class="label" for="note">
                                                <span class="label-text font-semibold text-base">Cover Letter / Note</span>
                                            </label>
                                            <textarea id="note" name="note" 
                                                      class="textarea textarea-bordered w-full h-40" 
                                                      placeholder="Write a short message to the employer... (e.g., 'Need more information...')"
                                                      required></textarea>
                                        </div>

                                        <div class="pt-4">
                                            <button type="submit" class="btn btn-secondary btn-lg w-full">
                                                <i class="fas fa-paper-plane mr-2"></i>
                                                Submit Application
                                            </button>
                                        </div>
                                        
                                        <c:if test="${not empty errorMessage}">
                                            <div class="alert alert-error shadow-lg mt-4">
                                                <div>
                                                    <i class="fas fa-exclamation-circle"></i>
                                                    <span>Error: <c:out value="${errorMessage}"/></span>
                                                </div>
                                            </div>
                                        </c:if>

                                    </form>
                                </div>
                            </div>
                        </c:when>
                        
                        <c:otherwise>
                            <div class="relative flex flex-col min-w-0 break-words bg-base-100 w-full mb-6 shadow-xl rounded-lg -mt-64">
                                <div class="px-6 py-24 text-center">
                                    <i class="fas fa-exclamation-triangle fa-3x text-error mb-4"></i>
                                    <h3 class="text-3xl font-semibold text-gray-700 mb-2">
                                        Cannot Apply
                                    </h3>
                                    <p class="text-gray-500 mb-6">
                                        <c:out value="${errorMessage}" default="The job you are trying to apply for is not available or has expired."/>
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
