<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<a href="${param.link}" class="flex flex-col gap-4 p-6 bg-base-100 w-md md:w-96 shadow-sm border border-[0.1px] rounded-box">
    <div class="flex items-center gap-4">
        <div class="size-30 rounded-box overflow-hidden">
            <img src="${param.src}" alt="${param.title}" class="w-full h-full object-cover"/>
        </div>
        <div class="flex flex-col gap-3">
            <span class="text-gray-400">${param.company}</span>
            <h1 class="text-base-content text-lg font-bold">${param.title}</h1>
            <div class="flex items-center gap-1">


                <c:forEach var="skill" items="${param.skills}">
                    <c:set var="newSkill" value="${fn:replace(fn:replace(skill, '[', ''), ']', '')}" />
                    <span class="badge badge-outline badge-secondary">${newSkill}</span>
                </c:forEach>

            </div>

            <span class="badge badge-ghost">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-3">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                    <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
                </svg>
                ${param.location}
            </span>
        </div>
    </div>

    <div class="flex items-center justify-between w-full mt-3">
        <span class="text-primary text-lg font-bold">

            ${param.salary} $ / Month

        </span>

        <span class="badge badge-outline">1 day ago</span>
    </div> 

</a>