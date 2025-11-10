<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%--
    Document   : manage.jsp
    (Đã thêm cột End Date)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <jsp:include page="/static/css/styles.jsp"/> 

        <title>Manage My Jobs - One1</title>

        <style>
            .table {
                width: 100%;
                border-collapse: collapse;
            }
            .table th, .table td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
                vertical-align: middle;
            }
            .table th {
                background-color: #f4f4f4;
            }
            .table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .table-actions {
                display: flex;
                gap: 15px;
            }
            .action-link {
                text-decoration: none;
                font-weight: 500;
                cursor: pointer;
            }
            .action-link-edit {
                color: #0066cc;
            }
            .action-link-delete {
                color: #cc0000;
            }
            .status-open {
                color: green;
                font-weight: 500;
            }
            .status-closed {
                color: red;
                font-weight: 500;
            }
        </style>
    </head>

    <jsp:include page="../../components/header.jsp"/>

    <body>
        <section class="max-w-lg md:max-w-7xl mx-auto my-36">
            <h1 class="text-xl md:text-3xl font-bold mb-8">My Jobs</h1> 
            
            <c:if test="${not empty error }">
                <div role="alert" class="alert alert-error w-full mb-4">
                    ${error}
                </div>
            </c:if>
            <c:if test="${param.deleteSuccess == true}">
                <div role="alert" class="alert alert-success w-full mb-4">
                    Xóa tin tuyển dụng thành công!
                </div>
            </c:if>
            <c:if test="${param.updateSuccess == true}">
                <div role="alert" class="alert alert-success w-full mb-4">
                    Cập nhật tin tuyển dụng thành công!
                </div>
            </c:if>

            <div class="overflow-x-auto">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Job Title</th>
                            <th>Date Posted</th>
                            <th>End Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="job" items="${jobList}">
                            <tr>
                                <td>${job.title}</td>
                                <td>
                                    <fmt:formatDate value="${job.createdAt}" pattern="dd-MM-yyyy" />
                                </td>
                                
                                <td>
                                    <fmt:formatDate value="${job.endDate}" pattern="dd-MM-yyyy" />
                                </td>
                                
                                <td>
                                    <c:if test="${job.status == 'open'}">
                                        <span class="status-open">Open</span>
                                    </c:if>
                                    <c:if test="${job.status == 'closed'}">
                                        <span class="status-closed">Closed</span>
                                    </c:if>
                                </td>
                                <td>
                                    <div class="table-actions">
                                        <a href="UpdateJob?jobId=${job.id}" class="action-link action-link-edit">
                                            Edit
                                        </a>
                                        <a href="DeleteJob?jobId=${job.id}" 
                                           class="action-link action-link-delete"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa tin: ${job.title}?');">
                                            Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty jobList}">
                            <tr>
                                <td colspan="5" style="text-align: center;">Bạn chưa đăng tin tuyển dụng nào.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

        </section> 
    </body>

    <jsp:include page="../../components/footer.jsp"/>

</html>