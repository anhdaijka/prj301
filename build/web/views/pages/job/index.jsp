<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 
    Document   : index
    Created on : Sep 30, 2025, 1:10:11 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/static/css/styles.jsp"/>
        <title>One1 HomePage - Your skills your deal</title>
    </head>

    <jsp:include page="../../components/header.jsp"/>

    <section class="w-full min-h-screen flex flex-col max-w-7xl mx-auto py-36">
        <jsp:include page="../../components/searchInput.jsp"/>
        <div class="max-w-7xl md:w-7xl mx-auto flex flex-col md:flex-row">
            <aside class="hidden md:block w-1/4 mr-6">
                <ul class="menu bg-base-200 rounded-box w-full">
                    <li>
                        <h2 class="menu-title">Sort Ascending / Descending</h2>
                        <ul>
                            <li><a>Work Language</a></li>
                            <li><a class="menu-active">Publication Date</a></li>
                            <li><a>Education Level</a></li>
                            <li><a>Job type</a></li>
                            <li><a>Distance</a></li>
                            <li><a>Salary (Monthly)</a></li>
                            <li><a>Work modes</a></li>
                            <li><a>Boss's beauty</a></li>
                        </ul>
                    </li>
                </ul>
            </aside>

            <div class="max-w-md mx-auto flex gap-2 items-center flex-wrap md:hidden my-4">
                <input class="btn" type="radio" name="options" aria-label="Work Language" />
                <input class="btn" type="radio" name="options" aria-label="Publication Date" />
                <input class="btn" type="radio" name="options" aria-label="Education Level" />
                <input class="btn" type="radio" name="options" aria-label="Job type" />
                <input class="btn" type="radio" name="options" aria-label="Distance" />
                <input class="btn" type="radio" name="options" aria-label="Salary" />
                <input class="btn" type="radio" name="options" aria-label="Work modes" />
                <input class="btn" type="radio" name="options" aria-label="Boss's beauty" />

            </div>
            <div class="flex-1 grid grid-cols-1 md:grid-cols-2 gap-6">
                <c:forEach var="i" begin="1" end="6">
                    <jsp:include page="/views/components/jobCard.jsp">
                        <jsp:param name="link" value="#"/>
                        <jsp:param name="src" value="https://gigamall.com.vn/data/2019/09/20/11491513_LOGO-McDonald_s.jpg"/>
                        <jsp:param name="company" value="Mcdonald's"/>
                        <jsp:param name="title" value="Web Developer"/>
                        <jsp:param name="skills" value="${pageScope.items}"/>
                        <jsp:param name="location" value="Hanoi"/>
                        <jsp:param name="salary" value="700"/>
                        <jsp:param name="className" value="md:w-[28rem]" />
                    </jsp:include>
                </c:forEach>
            </div>
        </div>
    </section>




    <jsp:include page="../../components/footer.jsp"/>

</html>
