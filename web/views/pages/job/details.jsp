<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 
    Document   : details (Job Details)
    Created on : Sep 30, 2025, 1:10:11 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/static/css/styles.jsp"/>
        
        <title>Chi tiết việc làm - <c:out value="${job.title}" default="Loading..."/></title>
    </head>

    <jsp:include page="../../components/header.jsp"/>

    <section class="w-full min-h-screen flex flex-col items-center justify-center max-w-7xl mx-auto">

        <section class="relative block h-[300px] sm:h-[400px] w-full">
            <div class="absolute top-0 w-full h-full bg-center bg-cover" style="
                 background-image: url('https://images.unsplash.com/photo-1497032628192-86f99d057135?q=80&w=1974&auto=format&fit=crop');
                 ">
                <span id="blackOverlay" class="w-full h-full absolute opacity-60 bg-black"></span>
            </div>
            <div class="top-auto bottom-0 left-0 right-0 w-full absolute pointer-events-none overflow-hidden h-70-px" style="transform: translateZ(0px)">
                <svg class="absolute bottom-0 overflow-hidden" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none" version="1.1" viewBox="0 0 2560 100" x="0" y="0">
                    <polygon class="text-base-200 fill-current" points="2560 0 2560 100 0 100"></polygon>
                </svg>
            </div>
        </section>
        
        <section class="relative py-16 bg-base-200 w-full">
            <div class="container mx-auto px-4">
                <div class="relative flex flex-col min-w-0 break-words bg-base-100 w-full mb-6 shadow-xl rounded-lg -mt-64">
                    <div class="px-6 py-10">

                        <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center mb-8">
                            <div>
                                <h3 class="text-4xl font-semibold leading-normal mb-2 text-base-content">
                                    <c:out value="${job.title}" default="Senior Java Developer"/>
                                </h3>
                                <div class="text-lg leading-normal mt-0 mb-2 text-gray-500 font-bold">
                                    <i class="fas fa-building mr-2 text-gray-400"></i>
                                    <c:out value="${job.companyName}" default="Awesome Tech Corp"/>
                                    (ID: <c:out value="${job.companyId}" default="C-12345"/>)
                                </div>
                                <div class="text-lg leading-normal mt-0 mb-2 text-gray-500 font-bold">
                                    <i class="fas fa-map-marker-alt mr-2 text-gray-400"></i>
                                    <c:out value="${job.location}" default="Ho Chi Minh City, Vietnam"/>
                                </div>
                            </div>
                            <div class="mt-6 sm:mt-0">
                                <a href="/apply?id=${job.id}" class="btn btn-secondary btn-lg w-full sm:w-auto">
                                    Ứng tuyển ngay
                                </a>
                            </div>
                        </div>

                        <div class="mt-10 py-10 border-t border-gray-200">
                            <h4 class="text-2xl font-semibold mb-4 text-base-content">Mô tả công việc</h4>
                            
                            <div class="flex flex-wrap justify-center">
                                <div class="w-full lg:w-11/12">
                                    <p class="mb-4 text-lg leading-relaxed text-gray-700">
                                        <c:out value="${job.description}" default="Mô tả công việc chi tiết sẽ được hiển thị ở đây. Chúng tôi đang tìm kiếm một Lập trình viên Java có kinh nghiệm để tham gia vào nhóm phát triển của chúng tôi. Bạn sẽ chịu trách nhiệm thiết kế, phát triển và duy trì các ứng dụng phần mềm... Lương khởi điểm : 500$"/>

                                    </p>
                                    
<!--                                    <h5 class="text-xl font-semibold mt-6 mb-2">Yêu cầu công việc</h5>
                                    <ul class="list-disc list-inside text-lg text-gray-700 leading-relaxed space-y-2">
                                        <li>3+ năm kinh nghiệm với Java, Spring Boot.</li>
                                        <li>Kinh nghiệm làm việc với cơ sở dữ liệu (SQL, NoSQL).</li>
                                        <li>Kỹ năng giải quyết vấn đề tốt.</li>
                                        <li>Bằng Cử nhân Khoa học Máy tính hoặc tương đương.</li>
                                    </ul>

                                    <h5 class="text-xl font-semibold mt-6 mb-2">Quyền lợi</h5>
                                    <ul class="list-disc list-inside text-lg text-gray-700 leading-relaxed space-y-2">
                                        <li>Mức lương cạnh tranh và thưởng hiệu suất.</li>
                                        <li>Bảo hiểm sức khỏe cao cấp.</li>
                                        <li>Môi trường làm việc linh hoạt, hỗ trợ remote.</li>
                                        <li>Cơ hội phát triển nghề nghiệp.</li>
                                    </ul>-->
                                </div>
                            </div>
                        </div>
                        </div>
                </div>
            </div>
            
        </section>
    </section>

    <jsp:include page="../../components/footer.jsp"/>

</html>