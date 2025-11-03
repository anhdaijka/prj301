<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="w-sm lg:w-[240px] aspect-[16/9] relative bg-base-100 border shadow-sm hover:shadow-lg flex flex-col p-4 md:flex-row gap-4 items-center">

    <div class="size-20 lg:size-16 rounded-box absolute left-[10%] -top-[25%] flex items-center justify-center bg-primary-content text-primary hover:bg-secondary-content hover:text-secondary">
        ${param.step}
    </div>


    <div class="flex flex-col items-start text-md w-full mt-5">
        <h2 class="font-bold"><c:out value="${param.title}"/></h2>
        <p class="tracking-wide text-gray-500"><c:out value="${param.sub}"/></p>
    </div>
</div>