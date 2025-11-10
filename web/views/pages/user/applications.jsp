<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <jsp:include page="/static/css/styles.jsp"/>

    
    <title>Đơn ứng tuyển của tôi</title>
</head>
<body class="bg-base-200">

    <jsp:include page="../../components/header.jsp"/>

    <main class="w-full min-h-screen py-12">
        <div class="container mx-auto max-w-7xl px-4">
            
            <h1 class="text-4xl font-bold mb-8 text-base-content">
                Đơn ứng tuyển của tôi
            </h1>

            <c:if test="${empty applications}">
                <div class="card bg-base-100 shadow-xl">
                    <div class="card-body items-center text-center">
                        <h2 class="card-title">Bạn chưa có đơn ứng tuyển nào!</h2>
                        <p>Hãy bắt đầu tìm kiếm công việc mơ ước của bạn ngay hôm nay.</p>
                        <div class="card-actions justify-end mt-4">
                            <a href="${pageContext.request.contextPath}/job" class="btn btn-secondary">Tìm việc ngay</a>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty applications}">
                <div class="card bg-base-100 shadow-xl">
                    <div class="overflow-x-auto">
                        <table class="table w-full">
                            <thead>
                                <tr>
                                    <th>Vị trí ứng tuyển</th>
                                    <th>Công ty</th>
                                    <th>Ngày nộp đơn</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            
                            <tbody>

                                <c:forEach var="app" items="${applications}">
                                    <tr>
                                        <td>
                                            <div class="flex items-center gap-3">
                                                <div>
                                                    <div class="font-bold">${app.jobTitle}</div>
                                                    <div class="text-sm opacity-50">${app.companyName}</div>
                                                </div>
                                            </div>
                                        </td>
                                        
                                        <td>
                                            <span class="text-sm">${app.submittedDate}</span>
                                        </td>

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
                                                <c:otherwise>
                                                    <span class="badge badge-ghost">${app.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>

                                            <a href="${pageContext.request.contextPath}/withdraw-application?id=${app.applicationId}"
                                               class="btn btn-error btn-outline btn-sm"
                                               onclick="return confirm('Bạn có chắc chắn muốn huỷ ứng tuyển cho vị trí này?');">
                                                Huỷ ứng tuyển
                                            </a>
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

    <jsp:include page="../../components/footer.jsp"/>

</body>
</html>