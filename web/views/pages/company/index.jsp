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

    <section class="w-full min-h-screen flex flex-col items-center justify-center max-w-7xl mx-auto">
        <section class="relative block h-[500px] w-full">
            <div class="absolute top-0 w-full h-full bg-center bg-cover" style="
                 background-image: url('https://anhdaik.vercel.app/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fcover.1a753d17.png&w=1920&q=75');
                 ">
                <span id="blackOverlay" class="w-full h-full absolute opacity-50 bg-black"></span>
            </div>
            <div class="top-auto bottom-0 left-0 right-0 w-full absolute pointer-events-none overflow-hidden h-70-px" style="transform: translateZ(0px)">
                <svg class="absolute bottom-0 overflow-hidden" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none" version="1.1" viewBox="0 0 2560 100" x="0" y="0">
                <polygon class="text-blueGray-200 fill-current" points="2560 0 2560 100 0 100"></polygon>
                </svg>
            </div>
        </section>
        <section class="relative py-16 bg-base-200">
            <div class="container mx-auto px-4">
                <div class="relative flex flex-col min-w-0 break-words bg-base-100 w-full mb-6 shadow-xl rounded-lg -mt-64">
                    <div class="px-6">
                        <div class="flex flex-wrap justify-center">
                            <div class="w-full lg:w-3/12 px-4 lg:order-2 avatar flex items-center justify-center">
                                <div class="relative rounded-full size-48 -top-1/2">
                                    <img alt="..." src="https://media.daily.dev/image/upload/s--wzOhK88f--/f_auto/v1724228753/avatars/avatar_nyNDZ2Trf7sk4FgOodgWN" 
                                         >
                                </div>
                            </div>
                            <div class="w-full lg:w-4/12 px-4 lg:order-3 lg:text-right lg:self-center">
                                <div class="py-6 px-3 mt-32 sm:mt-0">
                                    <button class="btn btn-secondary" type="button">
                                        Connect
                                    </button>
                                </div>
                            </div>
                            <div class="w-full lg:w-4/12 px-4 lg:order-1">
                                <div class="flex justify-center py-4 lg:pt-4 pt-8">
                                    <div class="mr-4 p-3 text-center">
                                        <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">22</span><span class="text-sm text-blueGray-400">Jobs</span>
                                    </div>
                                    <div class="mr-4 p-3 text-center">
                                        <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">10.8k</span><span class="text-sm text-blueGray-400">Reviews</span>
                                    </div>
                                    <div class="lg:mr-4 p-3 text-center">
                                        <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">89.8k</span><span class="text-sm text-blueGray-400">Salaries</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-center mt-12">
                            <h3 class="text-4xl font-semibold leading-normal mb-2 text-blueGray-700 mb-2">
                                BMW
                            </h3>
                            <div class="text-sm leading-normal mt-0 mb-2 text-blueGray-400 font-bold uppercase">
                                <i class="fas fa-map-marker-alt mr-2 text-lg text-blueGray-400"></i>
                                Los Angeles, California
                            </div>
                            <div class="mb-2 text-blueGray-600 mt-10">
                                <i class="fas fa-briefcase mr-2 text-lg text-blueGray-400"></i>Solution Manager - Creative Tim Officer
                            </div>
                            <div class="mb-2 text-blueGray-600">
                                <i class="fas fa-university mr-2 text-lg text-blueGray-400"></i>University of Computer Science
                            </div>
                        </div>
                        <div class="mt-10 py-10 border-t border-blueGray-200 text-center">
                            <div class="flex flex-wrap justify-center">
                                <div class="w-full lg:w-9/12 px-4">
                                    <p class="mb-4 text-lg leading-relaxed text-blueGray-700">
                                        An artist of considerable range, Jenna the name taken by
                                        Melbourne-raised, Brooklyn-based Nick Murphy writes,
                                        performs and records all of his own music, giving it a
                                        warm, intimate feel with a solid groove structure. An
                                        artist of considerable range.
                                    </p>
                                    <a href="#pablo" class="font-normal text-pink-500">Show more</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- name of each tab group should be unique -->
            <div class="container mx-auto px-4">
                <div class="bg-base-100 p-4 rounded-box shadow-sm flex flex-col gap-6">
                    <div role="tablist" class="tabs tabs-border">
                        <a role="tab" class="tab tab-active about">About Company</a>
                        <a role="tab" class="tab people">People</a>
                        <a role="tab" class="tab overview">Overview</a>
                        <a role="tab" class="tab jobs">Jobs</a>
                    </div>

                    <p class="" id="content"></p>
                </div>
            </div>

            <script>
                let tabs = document.querySelectorAll("a.tab");
                let activeTabs = document.querySelectorAll("a.tab.tab-active");
                let contentTab = document.querySelector("#content");
                let contents = [
                    {
                        name: "about",
                        contents: "About company"
                    }, {
                        name: "people",
                        contents: "People at here"
                    }, {
                        name: "overview",
                        contents: "Overview about company"
                    }, {
                        name: "jobs",
                        contents: "Jobs at here"
                    },
                ];

                let activeTab = document.querySelector("a.tab.tab-active");
                
                
                //Default content
                let setContent = () => {
                    activeTab = document.querySelector("a.tab.tab-active");

                    contents.forEach((content) => {
                        if (activeTab.classList.contains(content.name)) {
                            contentTab.innerHTML = content.contents;
                        }
                    })
                }
                
                setContent();

                tabs.forEach((tab) => {
                    tab.addEventListener('click', () => {
                        //Xoa tab active hien tai
                        activeTabs.forEach((activeTab) => {
                            activeTab.classList.remove("tab-active");
                        })
                        //Them tab active cho tab moi
                        tab.classList.add("tab-active");
                        //Reset buton
                        activeTabs = document.querySelectorAll("a.tab.tab-active");

                        //Set lai content
                        setContent();


                    })
                });

            </script>
        </section>
    </section>




    <jsp:include page="../../components/footer.jsp"/>

</html>
