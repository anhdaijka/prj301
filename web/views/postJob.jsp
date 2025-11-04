<%-- Import JSTL Core Library (Required) --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Post a New Job</title>

        <%-- Tagify Library (CSS) --%>
        <link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />

        <style>
            /* (CSS của bạn giữ nguyên) */
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
            }
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
            .error {
                color: #D8000C;
                font-weight: bold;
                background: #FFD2D2;
                border: 1px solid #D8000C;
                padding: 10px 15px;
                border-radius: 5px;
                text-align: center;
                margin-bottom: 20px;
            }

            /* CSS for Tagify */
            .tagify{
                --tag-bg: #007bff;
                --tag-text-color: #ffffff;
                border-radius: 5px;
                border: 1px solid #ccc;
                width: 100%;
                box-sizing: border-box;
            }
            .tagify__input {
                padding: 9px 12px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Post a New Job</h2>

            <c:if test="${not empty error or not empty listError}">
                <p class="error">
                    <c:if test="${not empty error}">${error}</c:if>
                    <c:if test="${not empty listError}">${listError}</c:if>
                    </p>
            </c:if>

            <form id="post-form" action="PostJobController" method="POST">

                <%-- 1. Job Title (Required) --%>
                <div class="form-group full-width">
                    <label for="title">Job Title (*):</label>
                    <input type="text" id="title" name="title" value="${param.title}">
                </div>

                <div class="form-grid">

                    <%-- 2. Category (Required) --%>
                    <div class="form-group">
                        <label for="categoryId">Category (*):</label>
                        <select id="categoryId" name="categoryId">
                            <option value="">-- Select Category --</option>
                            <c:forEach var="cat" items="${categoryList}">
                                <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>
                                    ${cat.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <%-- 3. Salary --%>
                    <div class="form-group">
                        <label for="salary">Salary:</label>
                        <input type="text" id="salary" name="salary" placeholder="Ex: $1000 - $1500" value="${param.salary}">
                    </div>

                    <%-- 4. Location --%>
                    <div class="form-group">
                        <label for="location">Location (*):</label>
                        <input type="text" id="location" name="location" placeholder="Ex: Hanoi, Ho Chi Minh City" value="${param.location}">
                    </div>

                    <%-- 5. End Date --%>
                    <div class="form-group">
                        <label for="endDate">End Date (dd/MM/yyyy):</label>
                        <input type="text" id="endDate" name="endDate" placeholder="dd/MM/yyyy" value="${param.endDate}">
                    </div>

                    <%-- 6. Working Hours --%>
                    <div class="form-group">
                        <label for="workingHours">Working Hours:</label>
                        <input type="text" id="workingHours" name="workingHours" placeholder="Ex: Office hours (Mon-Fri)" value="${param.workingHours}">
                    </div>

                    <%-- 7. Min Age --%>
                    <div class="form-group">
                        <label for="minAge">Min Age:</label>
                        <input type="number" id="minAge" name="minAge" placeholder="Leave blank if not required" value="${param.minAge}">
                    </div>

                    <%-- 8. Max Age --%>
                    <div class="form-group">
                        <label for="maxAge">Max Age:</label>
                        <input type="number" id="maxAge" name="maxAge" placeholder="Leave blank if not required" value="${param.maxAge}">
                    </div>

                    <%-- 9. Experience Level --%>
                    <div class="form-group">
                        <label for="experienceLevel">Experience Level:</label>
                        <select id="experienceLevel" name="experienceLevel">
                            <option value="">Not Required</option>
                            <option value="No experience" ${param.experienceLevel == 'No experience' ? 'selected' : ''}>No experience</option>
                            <option value="Less than 1 year" ${param.experienceLevel == 'Less than 1 year' ? 'selected' : ''}>Less than 1 year</option>
                            <option value="1-3 year" ${param.experienceLevel == '1-3 year' ? 'selected' : ''}>1-3 year</option>
                            <option value="+3 year" ${param.experienceLevel == '+3 year' ? 'selected' : ''}>+3 year</option>
                        </select>
                    </div>

                    <%-- 10. Degree Requirement --%>
                    <div class="form-group">
                        <label for="degreeRequirement">Degree Requirement:</label>
                        <select id="degreeRequirement" name="degreeRequirement">
                            <option value="">Not Required</option>
                            <option value="College" ${param.degreeRequirement == 'College' ? 'selected' : ''}>College</option>
                            <option value="University" ${param.degreeRequirement == 'University' ? 'selected' : ''}>University</option>
                        </select>
                    </div>

                    <%-- 11. Gender Requirement --%>
                    <div class="form-group">
                        <label for="genderRequirement">Gender Requirement:</label>
                        <select id="genderRequirement" name="genderRequirement">
                            <option value="">Not Required</option>
                            <option value="Male" ${param.genderRequirement == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${param.genderRequirement == 'Female' ? 'selected' : ''}>Female</option>
                        </select>
                    </div>
                </div> 

                <%-- 12. Job Description --%>
                <div class="form-group full-width">
                    <label for="description">Job Description:</label>
                    <textarea id="description" name="description" placeholder="Enter the detailed job description...">${param.description}</textarea>
                </div>

                <%-- 13. Benefits --%>
                <div class="form-group full-width">
                    <label for="benefits">Benefits:</label>
                    <textarea id="benefits" name="benefits" placeholder="Ex: Personal laptop, Health insurance, Team building...">${param.benefits}</textarea>
                </div>

                <%-- 14. Other Requirements --%>
                <div class="form-group full-width">
                    <label for="otherRequirements">Other Requirements:</label>
                    <textarea id="otherRequirements" name="otherRequirements" placeholder="Ex: Good communication, Driver's license...">${param.otherRequirements}</textarea>
                </div>

                <%-- 15. Required Skills (Tagify) --%>
                <div class="form-group full-width">
                    <label for="skills-input">Required Skills:</label>
                    <input type="text" id="skills-input" value="${param.skills_list}">

                    <%-- Hidden input to send data to Controller --%>
                    <input type="hidden" id="skills_list" name="skills_list">
                    <small><i>Type to search existing skills or add new skills and press Enter.</i></small>
                </div>

                <button type="submit" class="full-width">Post Job</button>
            </form>
        </div>


        <%-- =============================================== --%>
        <%-- JavaScript (Tagify)                             --%>
        <%-- =============================================== --%>

        <%-- 1. Add Tagify library (JS) --%>
        <script src="https://unpkg.com/@yaireo/tagify"></script>
        <script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {

                // --- 1. Handle Skills (Tagify) ---

                // 1a. Get the skill list from JSTL (Whitelist)
                const skillWhitelist = [
            <c:forEach var="skill" items="${skillList}">
                    "${skill.name}",
            </c:forEach>
                ];

                // 1b. Get the input element
                var input = document.getElementById('skills-input');

                // 1c. Initialize Tagify
                var tagify = new Tagify(input, {
                    whitelist: skillWhitelist, // Suggestion list
                    dropdown: {
                        maxItems: 20,
                        enabled: 0, // 0 = show dropdown on input
                        closeOnSelect: false
                    },
                    // (Tagify automatically allows new tags by default)
                });

                // --- 2. Handle Form Submit ---
                const form = document.getElementById('post-form');
                const hiddenSkillsInput = document.getElementById('skills_list');

                form.addEventListener('submit', function (e) {
                    // When user clicks "Post Job"

                    // Get all tags (as an array)
                    const tags = tagify.value.map(tag => tag.value);

                    // Join them into a single string, separated by commas
                    // Ex: "Java,SQL,Figma"
                    hiddenSkillsInput.value = tags.join(',');

                    // (The form can now submit)
                });
            });
        </script>

    </body>
</html>