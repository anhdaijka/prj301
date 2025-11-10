<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<a href="${param.link}" class="flex flex-col gap-4 p-6 bg-base-100 w-sm h-72 shadow-sm border border-[0.1px] rounded-box">
    <div class="flex items-start gap-4 h-full">

        <div class="avatar">
            <div class="w-24 rounded">
                <img src="${param.src}" alt="${param.title}" />
            </div>
        </div>
        <div class="flex flex-col gap-2 w-full overflow-hidden">
            <div class="w-full flex items-center justify-between">
                <h1 class="text-lg font-bold">${param.title}</h1>

                <span class="badge badge-secondary badge-ghost">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="Orange" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M11.48 3.499a.562.562 0 0 1 1.04 0l2.125 5.111a.563.563 0 0 0 .475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 0 0-.182.557l1.285 5.385a.562.562 0 0 1-.84.61l-4.725-2.885a.562.562 0 0 0-.586 0L6.982 20.54a.562.562 0 0 1-.84-.61l1.285-5.386a.562.562 0 0 0-.182-.557l-4.204-3.602a.562.562 0 0 1 .321-.988l5.518-.442a.563.563 0 0 0 .475-.345L11.48 3.5Z" />
                    </svg>
                    ${param.stars}</span>
            </div>
            <span class="text-gray-400">${param.location}</span>
            <div class="flex items-center gap-1">

                <c:forEach var="category" items="${param.categories}">
                    <c:set var="cat" value="${fn:replace(fn:replace(category, '[', ''), ']', '')}" />
                    <span class="badge badge-outline badge-secondary">${cat}</span>
                </c:forEach>

            </div>

            <p class="text-sm truncate text-pretty text-clip h-24">
                ${param.bio}
            </p>

            <p class="flex w-full items-center justify-between text-gray-400 text-xs mt-4">
                <span>
                    ${param.jobCount} Jobs
                </span>

                <span>
                    ${param.reviewCount}k Reviews
                </span>

                <span>
                    ${param.avgSalary}k Salaries
                </span>

            </p>
        </div>
    </div>



</a>