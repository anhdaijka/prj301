<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="fixed left-0 top-0 right-0 h-16 translate-y-1/2 navbar bg-base-100 rounded-md border border-[0.1px] max-w-7xl mx-auto z-[1000]">
    <div class="navbar-start">
        <div class="dropdown">
            <div tabindex="0" role="button" class="btn btn-ghost lg:hidden">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h8m-8 6h16" />
                </svg>
            </div>
            <ul tabindex="-1" class="menu menu-sm dropdown-content bg-base-100 rounded-box z-1 mt-3 w-52 p-2 shadow">
                <li><a href="/EmployeeManagement/">Home</a></li>
                <li><a href="/EmployeeManagement/views/pages/jobs.jsp">Find job</a></li>
                <li><a href="/EmployeeManagement/views/pages/company.jsp">Company</a></li>
            </ul>
        </div>
        <a class="btn btn-ghost text-xl">One1</a>
    </div>

    <div class="navbar-center hidden lg:flex">
        <ul class="menu menu-horizontal px-1">
            <li><a href="/EmployeeManagement/">Home</a></li>
            <li><a href="/EmployeeManagement/job">Find job</a></li>
            <li><a href="/EmployeeManagement/company">Company</a></li>
        </ul>
    </div>

    <div class="navbar-end flex items-center gap-4">

        <button>
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 hidden md:inline-block">
                <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
            </svg>
        </button>

        <c:choose>
            <c:when test="${empty sessionScope.user and empty sessionScope.role}">
                <span class="text-sm hidden md:inline-block">Not logged in</span>

                <a href="/EmployeeManagement/login" class="btn btn-ghost" title="Sign In">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 hidden md:inline-block">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6A2.25 2.25 0 005.25 5.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15" />
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9l3 3m0 0-3 3m3-3H3" />
                    </svg>
                    Sign In
                </a>

                <a href="/EmployeeManagement/signup" class="btn btn-secondary" title="Sign Up">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 hidden md:inline-block">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 9V5.25A2.25 2.25 0 0 1 10.5 3h6a2.25 2.25 0 0 1 2.25 2.25v13.5A2.25 2.25 0 0 1 16.5 21h-6a2.25 2.25 0 0 1-2.25-2.25V15m-3 0-3-3m0 0 3-3m-3 3H15" />
                    </svg>

                    Sign Up
                </a>
            </c:when>

            <c:otherwise>
                <c:set var="roleName" value="${not empty sessionScope.role ? sessionScope.role : sessionScope.user.role}" />
                <span class="hidden md:inline-block">${fn:toUpperCase(fn:substring(roleName, 0, 1))}${fn:toLowerCase(fn:substring(roleName, 1, fn:length(roleName)))}</span>
                <div class="divider divider-horizontal -mx-1"></div>

                <div class="dropdown dropdown-end">
                    <label tabindex="0" class="btn btn-ghost btn-circle avatar">
                        <div class="w-8 rounded-full">
                            <img src="/EmployeeManagement/" alt="avatar" />
                        </div>
                    </label>
                    <ul tabindex="0" class="mt-3 p-2 shadow menu menu-compact dropdown-content bg-base-100 rounded-box w-52">
                        <li><a href="/EmployeeManagement/views/pages/profile.jsp">Profile</a></li>
                        <li><a href="/EmployeeManagement/logout">Sign Out</a></li>
                    </ul>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>
