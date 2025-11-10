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

    <section class="w-full min-h-screen flex flex-col justify-center items-center max-w-7xl mx-auto py-36">

        <form action="/search" method="post" class="flex items-center flex-col gap-8 md:mb-8">
            <h1 class="font-bold text-3xl">Discover the Best Job</h1>
            <div class="join">
                <div>
                    <div>
                        <input class="input join-item min-w-[300px] md:min-w-md" placeholder="Job title or keywords" />
                    </div>
                </div>

                <div class="indicator">
                    <!--<span class="indicator-item badge badge-secondary">new</span>-->
                    <button class="btn join-item">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
                        </svg>

                        Search</button>
                </div>
            </div>
        </form>

        <div class="max-w-7xl mx-auto flex flex-col">

            <div class="max-w-md mx-auto flex gap-2 items-center flex-wrap my-4">
                <input class="btn" type="radio" name="options" aria-label="Work Language" />
                <input class="btn" type="radio" name="options" aria-label="Publication Date" />
                <input class="btn" type="radio" name="options" aria-label="Education Level" />
                <input class="btn" type="radio" name="options" aria-label="Job type" />
                <input class="btn" type="radio" name="options" aria-label="Distance" />
                <input class="btn" type="radio" name="options" aria-label="Salary" />
                <input class="btn" type="radio" name="options" aria-label="Work modes" />
                <input class="btn" type="radio" name="options" aria-label="Boss's beauty" />

            </div>
            <!--Default-->
            
            Found Job here
            
        </div>
    </section>




    <jsp:include page="../../components/footer.jsp"/>

</html>
