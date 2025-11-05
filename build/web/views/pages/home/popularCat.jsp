<%-- 
    Document   : popular
    Created on : Oct 27, 2025, 2:45:17 PM
    Author     : anhdaik
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="min-h-[50vh] w-full py-12">
    <jsp:include page="/views/components/heading.jsp">
        <jsp:param name="title" value="Popular Category"/>
        <jsp:param name="sub" value="The last job offers Upload"/>
    </jsp:include>

    <div class=" grid place-content-center">

        <div class="columns-1 md:columns-2 xl:columns-4 space-y-6">
            <c:forEach var="i" begin="1" end="8">
                <jsp:include page="/views/components/categoryCard.jsp">
                    <jsp:param name="title" value="Wordpress Developer"/>
                    <jsp:param name="sub" value="72+ Job available"/>
                </jsp:include>
            </c:forEach>
        </div>
    </div>
</div>
