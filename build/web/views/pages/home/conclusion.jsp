<%-- 
    Document   : popular
    Created on : Oct 27, 2025, 2:45:17 PM
    Author     : anhdaik
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.*" %>
<div class="hero min-h-[40vh]">
    <div class="hero-content flex-col lg:flex-row">

        <jsp:include page="/views/layouts/heading.jsp">
            <jsp:param name="title" value="Our Achievements in Hiring"/>
            <jsp:param name="sub" value="Wheter you're an employer looking for top talent or a job seeker searching for the perfect role, out platform has helped hundreds of professionals find success. Be the next one to achieve your career goals!"/>
        </jsp:include>

        <div class=" grid place-content-center">

            <div class="columns-1 md:columns-2 space-y-6">
                <c:forEach var="i" begin="1" end="4">
                    <jsp:include page="/views/layouts/categoryCard.jsp">
                        <jsp:param name="title" value="999+"/>
                        <jsp:param name="sub" value="Easy Application"/>
                    </jsp:include>
                </c:forEach>
            </div>
        </div>
    </div>

</div>
