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

    <section class="w-full min-h-screen flex flex-col max-w-7xl mx-auto py-24">
        <jsp:include page="../../components/comHead.jsp">
            <jsp:param name="name" value="BWM" />
            <jsp:param name="background" value="https://anhdaik.vercel.app/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fcover.1a753d17.png&w=1920&q=75" />
            <jsp:param name="avatar" value="https://media.daily.dev/image/upload/s--wzOhK88f--/f_auto/v1724228753/avatars/avatar_nyNDZ2Trf7sk4FgOodgWN" />
            <jsp:param name="location" value="Germany" />
            <jsp:param name="email" value="contact@bwm.com" />
            <jsp:param name="phone" value="+1 98482346" />
            <jsp:param name="size" value="1000" />
            
        </jsp:include>

    </section>




    <jsp:include page="../../components/footer.jsp"/>

</html>
