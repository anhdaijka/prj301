<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="fixed left-0 top-0 right-0 h-16 translate-y-1/2 navbar bg-base-100 rounded-md border border-[0.1px] max-w-7xl mx-auto z-[1000]">
    <div class="navbar-start">
        <div class="dropdown">
            <div tabindex="0" role="button" class="btn btn-ghost lg:hidden">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                          d="M4 6h16M4 12h8m-8 6h16" />
                </svg>
            </div>
            <ul tabindex="-1" class="menu menu-sm dropdown-content bg-base-100 rounded-box z-1 mt-3 w-52 p-2 shadow">
                <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/views/pages/job/index.jsp">Find job</a></li>
                <li><a href="${pageContext.request.contextPath}/views/pages/company/index.jsp">Company</a></li>
            </ul>
        </div>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-ghost text-xl">One1</a>
    </div>

    <div class="navbar-center hidden lg:flex">
        <ul class="menu menu-horizontal px-1">
            <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/views/pages/job/index.jsp">Find job</a></li>
            <li><a href="${pageContext.request.contextPath}/views/pages/company/index.jsp">Company</a></li>
        </ul>
    </div>

    <div class="navbar-end flex items-center gap-4">
        <button>
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                 stroke-width="1.5" stroke="currentColor" class="size-6 hidden md:inline-block">
                <path stroke-linecap="round" stroke-linejoin="round"
                      d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
            </svg>
        </button>

        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <span class="text-sm hidden md:inline-block">Not logged in</span>

                <a href="${pageContext.request.contextPath}/login" class="btn btn-ghost" title="Sign In">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" 
                         stroke-width="1.5" stroke="currentColor" class="size-6 hidden md:inline-block">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6A2.25 2.25 0 005.25 5.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15" />
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M12 9l3 3m0 0-3 3m3-3H3" />
                    </svg>
                    Sign In
                </a>

                <a href="${pageContext.request.contextPath}/signup" class="btn btn-secondary" title="Sign Up">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                         stroke-width="1.5" stroke="currentColor" class="size-6 hidden md:inline-block">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M8.25 9V5.25A2.25 2.25 0 0 1 10.5 3h6a2.25 2.25 0 0 1 2.25 2.25v13.5A2.25 2.25 0 0 1 16.5 21h-6a2.25 2.25 0 0 1-2.25-2.25V15m-3 0-3-3m0 0 3-3m-3 3H15" />
                    </svg>
                    Sign Up
                </a>
            </c:when>

            <c:otherwise>
                <c:set var="userObj" value="${sessionScope.user}" />
                <c:set var="userName" value="${not empty userObj.fullName ? userObj.fullName : sessionScope.userName}" />
                <c:set var="userRole" value="${not empty userObj.roleName ? userObj.roleName : sessionScope.userRole}" />
                <c:set var="userAvatar" value="${userObj.avatarUrl}" />
                <c:set var="userEmail" value="${userObj.email}" />

                <div class="flex items-center gap-3">
                    <c:choose>
                        <c:when test="${not empty userRole}">
                            <span class="text-sm font-medium text-gray-700">
                                ${fn:toUpperCase(fn:substring(userRole, 0, 1))}${fn:toLowerCase(fn:substring(userRole, 1, fn:length(userRole)))}
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-sm font-medium text-red-500">No Role</span>
                        </c:otherwise>
                    </c:choose>

                    <div class="divider divider-horizontal h-10 mx-0"></div>

                    <div class="dropdown dropdown-end">
                        <label tabindex="0" class="btn btn-ghost gap-2 normal-case hover:bg-gray-100 px-2">
                            <div class="avatar">
                                <div class="w-8 rounded-full">
                                    <c:choose>
                                        <c:when test="${not empty userAvatar}">
                                            <img src="${userAvatar}" alt="${userName}" />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://ui-avatars.com/api/?name=${fn:replace(userName, ' ', '+')}&background=random&color=fff&size=128"
                                                 alt="${userName}" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <span class="text-sm font-medium">${userName}</span>

                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                 stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                      d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
                            </svg>
                        </label>

                        <ul tabindex="0" class="mt-3 p-2 shadow menu dropdown-content bg-base-100 rounded-box w-52">
                            <li class="menu-title">
                                <span class="font-semibold">${userName}</span>
                                <span class="text-xs text-gray-500">${userEmail}</span>
                            </li>
                            <div class="divider my-1"></div>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/pages/profile.jsp">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                              d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                    </svg>
                                    Profile
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/logout">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                              d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                                    </svg>
                                    Sign Out
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
