<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="flex flex-col items-center gap-2 mb-12">
    <h1 class="text-4xl font-bold"><c:out value="${param.title}"/></h1>
    <span class="text-gray-500 font-light"><c:out value="${param.sub}"/></span>
</div>