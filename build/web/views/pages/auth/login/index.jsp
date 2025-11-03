<%-- 
    Document   : index
    Created on : Sep 30, 2025, 1:10:11 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/static/css/styles.jsp"/>
        <title>One1 HomePage - Your skills your deal</title>
    </head>


    <body>
        <div class="flex justify-center h-screen flex-row-reverse">
            <div class="hidden bg-cover lg:block lg:w-[60%]">
                <div class="flex items-center h-full bg-cover px-20 bg-opacity-40" 
                     style="background-image:
                     url('https://images.unsplash.com/photo-1758518727401-53823b36c47b?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1631');"
                     >
                    <div>
                        <div class="w-full mx-auto rounded-lg bg-base-100 shadow p-5 text-base-content min-w-[500px] translate-y-4/5">
                            <div class="w-full flex mb-4">
                                <div class="overflow-hidden rounded-full w-12 h-12">
                                    <img src="https://media.daily.dev/image/upload/s--wzOhK88f--/f_auto/v1724228753/avatars/avatar_nyNDZ2Trf7sk4FgOodgWN" alt="">
                                </div>
                                <div class="flex-grow pl-3">
                                    <h6 class="font-bold text-md">Phùng Quang Anh</h6>
                                    <p class="text-xs text-gray-600">Job seeker</p>
                                </div>
                                <div class="w-12 text-right">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-twitter-icon lucide-twitter"><path d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z"/></svg>
                                </div>
                            </div>
                            <div class="w-full mb-4">
                                <p class="text-sm">
                                    What struck me most during my application process with
                                    Canon was the intentionality behind every step. 
                                    Every communication thoughtful.
                                    Every interviewer came prepared.
                                    And more than that, they wanted to understand not just what
                                    I could do.


                                </p>
                            </div>
                            <div class="w-full">
                                <p class="text-xs text-gray-500 text-right">Oct 15th 8:33pm</p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="flex items-center w-full max-w-md px-6 mx-auto lg:w-2/6">
                <div class="flex-1">
                    <div class="text-center">
                        <div class="flex justify-center mx-auto">
                            <img src="https://iconape.com/wp-content/files/ww/350307/png/350307.png"  class='w-56'/>
                        </div>

                        <p class="mt-3 text-gray-600">Sign in to access your account</p>
                    </div>

                    <div class="mt-8">
                        <form action="/EmployeeManagement/login" method="post">
                            <fieldset class="fieldset">
                                <legend class="fieldset-legend">Email address *
                                </legend>
                                <input type="email" class="input w-full" placeholder="Your email here" name="username"/>
                            </fieldset>

                            <fieldset class="fieldset">
                                <legend class="fieldset-legend">Password *</legend>
                                <input type="password" class="input w-full" placeholder="Type your password" name="password"/>
                                <a href="#" class="label text-sm text-error focus:text-warning hover:text-warning hover:underline">Forgot password?</a>
                            </fieldset>

                            <div class="mt-6 text-center">
                                <button type="submit" class="btn btn-secondary w-full">Log In</button>
                            </div>

                        </form>

                        <p class="mt-6 text-sm text-center text-gray-400">Don&#x27;t have an account yet? <a href="/EmployeeManagement/signup" class="text-secondary focus:outline-none focus:underline hover:underline">Sign up</a>.</p>
                    </div>
                </div>
            </div>
        </div>

    </body>


</html>
