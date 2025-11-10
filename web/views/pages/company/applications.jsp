<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <jsp:include page="/static/css/styles.jsp"/>
    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" /> -->
    <title>Đơn ứng tuyển cho: ${job.title}</title>
</head>
<body class="bg-base-200">

    <!-- Header -->
    <jsp:include page="../../components/header.jsp"/>

    <!-- Phần nội dung chính -->
    <main class="w-full min-h-screen py-12">
        <div class="container mx-auto max-w-7xl px-4">
            
            <!-- Nút quay lại -->
            <a href="${pageContext.request.contextPath}/company/jobs" class="btn btn-ghost mb-4">
                <i class="fas fa-arrow-left mr-2"></i> Quay lại
            </a>
            
            <h1 class="text-4xl font-bold mb-2 text-base-content">
                Đơn ứng tuyển
            </h1>
            <h2 class="text-2xl text-gray-500 font-medium mb-8">
                Cho vị trí: <c:out value="${job.title}" default="Loading..."/>
            </h2>

            <!-- Kiểm tra nếu danh sách rỗng -->
            <c:if test="${empty jobApplications}">
                <div class="card bg-base-100 shadow-xl">
                    <div class="card-body items-center text-center">
                        <h2 class="card-title">Chưa có ứng viên nào!</h2>
                        <p>Hiện tại chưa có ai nộp đơn cho vị trí này.</p>
                    </div>
                </div>
            </c:if>

            <!-- Chỉ hiển thị bảng nếu danh sách không rỗng -->
            <c:if test="${not empty jobApplications}">
                <div class="card bg-base-100 shadow-xl">
                    <div class="overflow-x-auto">
                        <table class="table w-full">
                            <!-- Phần đầu bảng -->
                            <thead>
                                <tr>
                                    <th>Ứng viên</th>
                                    <th>Email</th>
                                    <th>Ngày nộp đơn</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            
                            <!-- Phần thân bảng -->
                            <tbody>
                                <!-- 
                                    Giả sử 'jobApplications' là danh sách đơn cho job này
                                    - app.applicationId
                                    - app.user (Object)
                                        - user.fullName
                                        - user.email
                                        - user.avatarUrl (optional)
                                    - app.submittedDate
                                    - app.status ("Đang chờ", "Đã duyệt", "Bị từ chối")
                                -->
                                <c:forEach var="app" items="${jobApplications}">
                                    <tr>
                                        <!-- Tên ứng viên -->
                                        <td>
                                            <div class="flex items-center gap-3">
                                                <div class="avatar">
                                                    <div class="mask mask-squircle w-12 h-12">
                                                        <img src="${not empty app.user.avatarUrl ? app.user.avatarUrl : 'https://placehold.co/100x100/F0F0F0/B0B0B0?text=User'}" 
                                                             alt="Avatar" />
                                                    </div>
                                                </div>
                                                <div>
                                                    <div class="font-bold">${app.user.fullName}</div>
                                                    <%-- Có thể thêm link tới CV ở đây --%>
                                                    <a href="${pageContext.request.contextPath}/view-cv?id=${app.cvId}" class="text-sm link link-info" target="_blank">Xem CV</a>
                                                </div>
                                            </div>
                                        </td>
                                        
                                        <!-- Email -->
                                        <td>${app.user.email}</td>

                                        <!-- Ngày nộp -->
                                        <td>${app.submittedDate}</td>

                                        <!-- Trạng thái -->
                                        <td>
                                            <c:choose>
                                                <c:when test="${app.status == 'Đang chờ'}">
                                                    <span class="badge badge-info badge-ghost">${app.status}</span>
                                                </c:when>
                                                <c:when test="${app.status == 'Đã duyệt'}">
                                                    <span class="badge badge-success badge-ghost">${app.status}</span>
                                                </c:when>
                                                <c:when test="${app.status == 'Bị từ chối'}">
                                                    <span class="badge badge-error badge-ghost">${app.status}</span>
                                                </c:when>
                                            </c:choose>
                                        </td>

                                        <!-- Nút Duyệt / Từ chối -->
                                        <td>
                                            <!-- Chỉ hiển thị nút nếu trạng thái là "Đang chờ" -->
                                            <c:if test="${app.status == 'Đang chờ'}">
                                                <div class="flex flex-col sm:flex-row gap-2">
                                                    <a href="${pageContext.request.contextPath}/company/approve-application?appId=${app.applicationId}"
                                                       class="btn btn-success btn-outline btn-sm">
                                                        Duyệt
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/company/reject-application?appId=${app.applicationId}"
                                                       class="btn btn-error btn-outline btn-sm">
                                                        Từ chối
                                                    </a>
                                                </div>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>

        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="../../components/footer.jsp"/>

</body>
</html>