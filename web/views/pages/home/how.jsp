<%-- 
    Document   : popular
    Created on : Oct 27, 2025, 2:45:17 PM
    Author     : anhdaik
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.*" %>
<div class="min-h-[50vh] w-full py-12 relative">
    <jsp:include page="/views/layouts/heading.jsp">
        <jsp:param name="title" value="Steps to Your Dream Job"/>
        <jsp:param name="sub" value="The last job offers Upload"/>
    </jsp:include>



        <div class="flex items-center justify-center">
            <div class="grid grid-cols-1 lg:grid-cols-4 gap-18 lg:gap-6 mt-6 lg:mt-0">
                
            <jsp:include page="/views/components/stepCard.jsp">
                <jsp:param name="step" value="1"/>
                <jsp:param name="title" value="Create account"/>
                <jsp:param name="sub" value="Start your journey today. Nulla facilisi. Aenean et tortor at elit luctus"/>
            </jsp:include>

            <jsp:include page="/views/components/stepCard.jsp">
                <jsp:param name="step" value="2"/>
                <jsp:param name="title" value="Upload CV / Resume"/>
                <jsp:param name="sub" value="Easily upload your resume. Donec euismod velit at tempor, ut cursus."/>
            </jsp:include>

            <jsp:include page="/views/components/stepCard.jsp">
                <jsp:param name="step" value="3"/>
                <jsp:param name="title" value="Find suitable job"/>
                <jsp:param name="sub" value="Discover jobs for you. In hac habitasse platea dictumst. Morbi imperdiet."/>
            </jsp:include>

            <jsp:include page="/views/components/stepCard.jsp">
                <jsp:param name="step" value="4"/>
                <jsp:param name="title" value="Apply job"/>
                <jsp:param name="sub" value="Apply in just a click. Sed luctus, lorem id pharetra dapibus, velit nisi."/>
            </jsp:include>
        </div>
        </div>
</div>
</div>
