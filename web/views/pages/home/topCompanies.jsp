<%-- 
    Document   : popular
    Created on : Oct 27, 2025, 2:45:17 PM
    Author     : anhdaik
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.*" %>
<div class="min-h-[50vh] w-full py-12 relative">
    <jsp:include page="/views/components/heading.jsp">
        <jsp:param name="title" value="Top Companies"/>
        <jsp:param name="sub" value="The last job offers Upload"/>
    </jsp:include>

    <a href="#" class="absolute right-8 top-24 hover:underline text-secondary"> More ></a>
    <% List<String> items = Arrays.asList("ReactJS", "ExpressJS");
        pageContext.setAttribute("items", items); %>

    <div class="flex items-center justify-center">

        <div class="grid grid-cols-1 xl:grid-cols-3 gap-12 lg:gap-6">
            <jsp:include page="/views/components/comCard.jsp">
                <jsp:param name="link" value="#"/>
                <jsp:param name="src" value="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4OiSP_7PaeZOblrnqTRzv8KZkj-ZUKgGmmQ&s"/>
                <jsp:param name="title" value="Sandro"/>
                <jsp:param name="categories" value="${pageScope.items}"/>
                <jsp:param name="location" value="Bergen"/>
                <jsp:param name="bio" value="Sandro is a French fashion brand known for its chic, comtemporary collections. offering men."/>

                <jsp:param name="stars" value="4.5"/>
            </jsp:include>

            <jsp:include page="/views/components/comCard.jsp">
                <jsp:param name="link" value="#"/>
                <jsp:param name="src" value="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSTWlnJCnn2ljYqv2t4XY9bM5U4pnohvXZRw&s"/>
                <jsp:param name="title" value="Microsoft"/>
                <jsp:param name="categories" value="${pageScope.items}"/>
                <jsp:param name="location" value="Los Angeles"/>
                <jsp:param name="bio" value="Microsoft Corporation is an American multinational technology conglomerate headquartered in Redmond, Washington."/>

                <jsp:param name="stars" value="4.8"/>
            </jsp:include>           

            <jsp:include page="/views/components/comCard.jsp">
                <jsp:param name="link" value="#"/>
                <jsp:param name="src" value="https://gigamall.com.vn/data/2019/09/20/11491513_LOGO-McDonald_s.jpg"/>
                <jsp:param name="title" value="Mcdonald's"/>
                <jsp:param name="categories" value="${pageScope.items}"/>
                <jsp:param name="location" value="Washington"/>
                <jsp:param name="bio" value="McDonald's was founded by brothers Richard and Maurice McDonald in 1940 as a drive-in restaurant in California, which they later transformed in 1948 into a fast-food hamburger restaurant using their innovative \"Speedee Service System\"."/>
                <jsp:param name="stars" value="4.1"/>
            </jsp:include>

        </div>
    </div>
</div>
