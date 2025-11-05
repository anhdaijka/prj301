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
    <a href="#" class="absolute right-8 top-24 hover:underline text-secondary"> More ></a>

    <% List<String> items = Arrays.asList("ReactJS", "ExpressJS");
        pageContext.setAttribute("items", items); %>

    <div class=" grid place-content-center">

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="i" begin="1" end="6">
                <jsp:include page="/views/components/jobCard.jsp">
                    <jsp:param name="link" value="#"/>
                    <jsp:param name="src" value="https://gigamall.com.vn/data/2019/09/20/11491513_LOGO-McDonald_s.jpg"/>
                    <jsp:param name="company" value="Macdonald's"/>
                    <jsp:param name="title" value="Web Developer"/>
                    <jsp:param name="skills" value="${pageScope.items}"/>
                    <jsp:param name="location" value="Hanoi"/>
                    <jsp:param name="salary" value="700"/>
                </jsp:include>
            </c:forEach>
        </div>
    </div>
</div>
