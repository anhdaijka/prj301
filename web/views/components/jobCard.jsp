<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<a href="${param.link}" 
   class="group flex w-sm md:w-fit flex-col md:flex-row gap-4 p-5 sm:p-6 bg-base-100 rounded-xl shadow-md hover:shadow-lg hover:-translate-y-1 transition-all duration-300 ${param.className}">

    <div class="w-full md:w-36 h-36 flex-shrink-0 rounded-xl overflow-hidden bg-base-200">
        <img src="${param.src}" alt="${param.title}"
             class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300" />
    </div>

    <div class="flex flex-col justify-between flex-1 gap-3">
        <div>
            <span class="text-sm text-gray-400 font-medium block mb-1">
                <c:out value="${param.company}" />
            </span>

            <h2 class="text-lg sm:text-xl font-bold text-base-content leading-tight group-hover:text-primary transition-colors">
                <c:out value="${param.title}" />
            </h2>

            <div class="flex flex-wrap items-center gap-1.5 mt-2">
                <c:forEach var="skill" items="${param.skills}">
                    <c:set var="cleanSkill" value="${fn:replace(fn:replace(skill, '[', ''), ']', '')}" />
                    <span class="badge badge-outline badge-sm text-xs">${cleanSkill}</span>
                </c:forEach>
            </div>

            <div class="flex items-center gap-1 mt-3 text-gray-500 text-sm">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                     stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
                </svg>
                <span><c:out value="${param.location}" /></span>
            </div>
        </div>

        <div class="flex items-center justify-between w-full mt-4">
            <span class="text-success text-md font-semibold">
                <c:out value="${param.salary}" />$/M
            </span>
            <span class="text-sm text-gray-400 whitespace-nowrap">1 day ago</span>
        </div>
    </div>
</a>
