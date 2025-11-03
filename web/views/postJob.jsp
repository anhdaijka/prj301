
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đăng Tin Tuyển Dụng Mới</title>
        <style>
            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
                margin: 20px;
                background-color: #f7f7f7;
            }
            .container {
                max-width: 800px;
                margin: auto;
                background: #fff;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            }
            h2 {
                text-align: center;
                color: #333;
            }
            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .full-width {
                grid-column: 1 / -1;
            } /* Class để 1 trường chiếm 2 cột */
            label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: #555;
            }
            input[type="text"], input[type="number"], select, textarea {
                width: 100%;
                padding: 9px 12px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            textarea {
                height: 120px;
                resize: vertical;
            }
            .skill-list {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 10px;
                border: 1px solid #ccc;
                padding: 10px;
                border-radius: 5px;
                max-height: 200px;
                overflow-y: auto;
            }
            .skill-item label {
                font-weight: normal;
                margin-left: 5px;
            }
            .skill-item {
                display: flex;
                align-items: center;
            }
            button {
                width: 100%;
                padding: 12px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
            }
            button:hover {
                background-color: #0056b3;
            }

            /* Thông báo lỗi */
            .error {
                color: #D8000C; /* Màu đỏ đậm */
                font-weight: bold;
                background: #FFD2D2; /* Màu nền đỏ nhạt */
                border: 1px solid #D8000C;
                padding: 10px 15px;
                border-radius: 5px;
                text-align: center;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Đăng Tin Tuyển Dụng Mới</h2>

            <c:if test="${not empty error or not empty listError}">
                <p class="error">
                    <c:if test="${not empty error}">${error}</c:if>
                    <c:if test="${not empty listError}">${listError}</c:if>
                    </p>
            </c:if>

            <form action="PostJob" method="POST">

                <div class="form-group full-width">
                    <label for="title">Tiêu đề công việc (*):</label>
                    <input type="text" id="title" name="title" value="${param.title}">
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="categoryId">Danh mục:</label>
                        <select id="categoryId" name="categoryId">
                            <option value="">-- Tùy chọn (Không chọn) --</option>

                            <c:forEach var="cat" items="${categoryList}">
                                <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>
                                    ${cat.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="salary">Mức lương:</label>
                        <input type="text" id="salary" name="salary" placeholder="VD: 10-15 triệu hoặc Thỏa thuận" value="${param.salary}">
                    </div>

                    <div class="form-group">
                        <label for="location">Địa điểm làm việc:</label>
                        <input type="text" id="location" name="location" placeholder="VD: Hà Nội, TP. HCM" value="${param.location}">
                    </div>

                    <div class="form-group">
                        <label for="endDate">Ngày kết thúc:</label>
                        <input type="text" id="endDate" name="endDate" placeholder="dd/MM/yyyy" value="${param.endDate}">
                    </div>

                    <div class="form-group">
                        <label for="workingHours">Giờ làm việc:</label>
                        <input type="text" id="workingHours" placeholder="VD: Giờ hành chính (T2-T6)" name="workingHours" value="${param.workingHours}">
                    </div>

                    <div class="form-group">
                        <label for="minAge">Tuổi tối thiểu:</label>
                        <input type="number" id="minAge" name="minAge" placeholder="Bỏ trống nếu không yêu cầu" value="${param.minAge}">
                    </div>

                    <div class="form-group">
                        <label for="maxAge">Tuổi tối đa:</label>
                        <input type="number" id="maxAge" name="maxAge" placeholder="Bỏ trống nếu không yêu cầu" value="${param.maxAge}">
                    </div>
                </div> <%-- Hết .form-grid --%>

                <div class="form-group full-width">
                    <label for="description">Mô tả công việc:</label>
                    <textarea id="description" name="description">${param.description}</textarea>
                </div>

                <div class="form-group full-width">
                    <label>Kỹ năng yêu cầu:</label>
                    <div class="skill-list">
                        <c:forEach var="skill" items="${skillList}">
                            <div class="skill-item">
                                <input type="checkbox" id="skill_${skill.id}" name="skillIds" value="${skill.id}">
                                <label for="skill_${skill.id}">${skill.name}</label>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <button type="submit" class="full-width">Đăng Tin</button>
            </form>
        </div>

    </body>
</html>
