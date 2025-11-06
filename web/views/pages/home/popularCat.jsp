<%-- 
    Document   : popular
    Created on : Oct 27, 2025, 2:45:17 PM
    Author     : anhdaik
--%>
<%--<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="min-h-[50vh] w-full py-12">
    <jsp:include page="/views/components/heading.jsp">
        <jsp:param name="title" value="Popular Category"/>
        <jsp:param name="sub" value="The last job offers Upload"/>
    </jsp:include>

    <div class=" grid place-content-center">
        <div class="columns-1 md:columns-2 xl:columns-4 space-y-6">
            <c:forEach var="c" items="${requestScope.categories}">
                <jsp:include page="/views/components/categoryCard.jsp">
                    <jsp:param name="title" value="${c.name}"/>
                    <jsp:param name="sub" value="${c.jobCount}+ Job available"/>
                </jsp:include>
            </c:forEach>
        </div>
    </div>
</div>--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="w-full py-16 bg-gray-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <!-- Header -->
        <div class="text-center mb-12">
            <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-3">
                Popular Category
            </h2>
            <p class="text-gray-500 text-lg">
                The last job offers Upload
            </p>
        </div>
        
        <!-- Category Grid - Tự động điều chỉnh số cột -->
        <div class="grid gap-6" 
             style="grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));">
            <c:forEach var="c" items="${requestScope.categories}">
                <jsp:include page="/views/components/categoryCard.jsp">
                    <jsp:param name="title" value="${c.name}"/>
                    <jsp:param name="sub" value="${c.jobCount}+ Job available"/>
                </jsp:include>
            </c:forEach>
        </div>
        
        <!-- Empty state -->
        <c:if test="${empty requestScope.categories}">
            <div class="text-center py-12">
                <svg class="w-16 h-16 text-gray-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                          d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                </svg>
                <p class="text-gray-500 text-lg">No categories available yet</p>
            </div>
        </c:if>
    </div>
</div>