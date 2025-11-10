<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <jsp:include page="/static/css/styles.jsp"/>
    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" /> -->
    <title>Quản lý Tin tuyển dụng</title>
</head>
<body class="bg-base-200">

    <!-- Header -->
    <jsp:include page="../../components/header.jsp"/>

    <!-- Phần nội dung chính của Dashboard (Company) -->
    <main class="w-full min-h-screen py-12">
        <div class="container mx-auto max-w-7xl px-4">
            
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-8">
                <h1 class="text-4xl font-bold text-base-content">
                    Quản lý Tin tuyển dụng
                </h1>
                <!-- Nút Create (Tạo mới) -->
                <a href="${pageContext.request.contextPath}/company/create-job" class="btn btn-secondary mt-4 sm:mt-0">
                    <i class="fas fa-plus mr-2"></i> Đăng tin mới
                </a>
            </div>

            <!-- Kiểm tra nếu danh sách rỗng -->
            <c:if test="${empty companyJobs}">
                <div class="card bg-base-100 shadow-xl">
                    <div class="card-body items-center text-center">
                        <h2 class="card-title">Bạn chưa đăng tin tuyển dụng nào!</h2>
                        <p>Hãy bắt đầu đăng tin để tìm kiếm ứng viên tài năng ngay.</p>
                        <div class="card-actions justify-end mt-4">
                            <a href="${pageContext.request.contextPath}/company/create-job" class="btn btn-primary">Đăng tin ngay</a>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Chỉ hiển thị bảng nếu danh sách không rỗng -->
            <c:if test="${not empty companyJobs}">
                <div class="card bg-base-100 shadow-xl">
                    <div class="overflow-x-auto">
                        <table class="table w-full">
                            <!-- Phần đầu bảng -->
                            <thead>
                                <tr>
                                    <th>Vị trí tuyển dụng</th>
                                    <th>Trạng thái</th>
                                    <th>Số đơn</th>
                                    <th>Ngày đăng</th>
                                    <th>Hành động (CRUD)</th>
                                </tr>
                            </thead>
                            
                            <!-- Phần thân bảng -->
                            <tbody>
                                <!-- 
                                    Giả sử 'companyJobs' là danh sách các job của công ty
                                    - job.jobId
                                    - job.title
                                    - job.location
                                    - job.status ("Đang tuyển", "Đã đóng")
                                    - job.applicationCount (int)
                                    - job.postedDate (String hoặc Date)
                                -->
                                <c:forEach var="job" items="${companyJobs}">
                                    <tr>
                                        <!-- Vị trí -->
                                        <td>
                                            <div class="font-bold">${job.title}</div>
                                            <div class="text-sm opacity-50">${job.location}</div>
                                        </td>

                                        <!-- Trạng thái -->
                                        <td>
                                            <c:choose>
                                                <c:when test="${job.status == 'Đang tuyển'}">
                                                    <span class="badge badge-success badge-ghost">${job.status}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-ghost">${job.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        
                                        <!-- Số đơn ứng tuyển -->
                                        <td>
                                            <span class="font-bold text-lg">${job.applicationCount}</span>
                                        </td>

                                        <!-- Ngày đăng -->
                                        <td>${job.postedDate}</td>

                                        <!-- Nút Hành động (CRUD) -->
                                        <td>
                                            <div class="flex flex-col sm:flex-row gap-2">
                                                <!-- Nút Read (Xem đơn ứng tuyển) -->
                                                <a href="${pageContext.request.contextPath}/company/job-applications?jobId=${job.jobId}"
                                                   class="btn btn-info btn-outline btn-sm">
                                                    Xem đơn
                                                </a>
                                                
                                                <!-- Nút Update (Sửa) -->
                                                <a href="${pageContext.request.contextPath}/company/edit-job?jobId=${job.jobId}"
                                                   class="btn btn-ghost btn-sm">
                                                    Sửa
                                                </a>
                                                
                                                <!-- Nút Delete (Xoá) -->
                                                <a href="${pageContext.request.contextPath}/company/delete-job?jobId=${job.jobId}"
                                                   class="btn btn-error btn-outline btn-sm"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xoá tin tuyển dụng này?');">
                                                    Xoá
                                                </a>
                                            </div>
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