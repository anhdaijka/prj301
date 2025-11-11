<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
    Document   : update.jsp
    (Dựa trên post.jsp, dành riêng cho Cập nhật)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/static/css/styles.jsp"/> 

        <title>Update Job - One1</title>
    </head>

    <jsp:include page="../../components/header.jsp"/>

    <body>
        <section class="max-w-lg md:max-w-3xl mx-auto my-36 grid place-content-center">

            <form action="UpdateJob" method="post" class="min-w-sm md:min-w-xl flex flex-col items-center justify-center gap-6">

                <h1 class="text-xl md:text-3xl font-bold">Update Job</h1>
                <c:if test="${not empty error }">
                    <div role="alert" class="alert ${param.alert} alert-error w-full h-12 text-center" id="message">
                        <c:if test="${not empty error}">${error}</c:if>
                        </div>
                </c:if>

                <input type="hidden" name="jobId" value="${job.id}" />

                <fieldset class="fieldset w-full">
                    <legend class="fieldset-legend">Job title (*)</legend>
                    <input type="text" class="input w-full" placeholder="My awesome page" name="title" required
                           oninvalid="this.setCustomValidity('Please enter Job title')"
                           oninput="this.setCustomValidity('')" 
                           value="${job.title}" />
                </fieldset>



                <div class="flex flex-col md:flex-row gap-6 items-center w-full">

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Category (*)</legend>
                        <select class="select w-full" name="categoryId" required 
                                oninvalid="this.setCustomValidity('Please select Catergory')"
                                oninput="this.setCustomValidity('')">
                            <option value="" hidden disabled>- Select category -</option>
                            <c:forEach var="cat" items="${categoryList}">
                                <option value="${cat.id}" <c:if test="${job.categoryId == cat.id}">selected</c:if>>
                                    ${cat.name}
                                </option>
                            </c:forEach>
                        </select>
                    </fieldset>

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Minium Salaries</legend>
                        <input type="text" class="input w-full validator" min="100" placeholder="Ex: $1000 - $1500" name="salary" 
                               value="${job.salary}"/>
                    </fieldset>

                </div>

                <div class="flex flex-col md:flex-row gap-6 items-center w-full">

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Location (*)</legend>
                        <input type="text" class="input w-full validator" placeholder="Ex: Hanoi, Ho Chi Minh City" name="location" required
                               oninvalid="this.setCustomValidity('Please enter Location')"
                               oninput="this.setCustomValidity('')" 
                               value="${job.location}"/>
                    </fieldset>

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">End date (*)</legend>
                        <input type="date" class="input validator w-full" required placeholder="Pick a date from 2025" 
                               min="2025-01-01"
                               title="Must be valid date" name="endDate" 
                               value="${job.endDate}" />
                    </fieldset>

                </div>


                <div class="flex flex-col md:flex-row gap-6 items-center w-full">

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Working hours</legend>
                        <input type="text" class="input w-full validator" placeholder="Ex: Office hours (Monday - Friday)" name="workingHours" 
                               value="${job.workingHours}"/>
                    </fieldset>

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Experience level (*)</legend>
                        <select class="select w-full" name="experienceLevel" required>
                            <option hidden disabled>- Select level -</option>
                            <option <c:if test="${job.experienceLevel == 'Not required'}">selected</c:if>>Not required</option>
                            <option <c:if test="${job.experienceLevel == 'Fresher'}">selected</c:if>>Fresher</option>
                            <option <c:if test="${job.experienceLevel == 'Junior'}">selected</c:if>>Junior</option>
                            <option <c:if test="${job.experienceLevel == 'Senior'}">selected</c:if>>Senior</option>
                            </select>
                        </fieldset>

                    </div>

                    <div class="flex flex-col md:flex-row gap-6 items-center w-full">

                        <fieldset class="fieldset flex-1 w-full">
                            <legend class="fieldset-legend">Min age</legend>
                            <input type="number" class="input validator w-full" placeholder="Leave blank if not required" 
                                   min="18"
                                   max="49"
                                   title="Minium 18 years old" name="minAge" 
                                   value="${job.minAge}"/>
                    </fieldset>

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Max age</legend>
                        <input type="number" class="input validator w-full" placeholder="Leave blank if not required"
                               min="18"
                               max="50"
                               title="Maxium 50 years old" name="maxAge" 
                               value="${job.maxAge}"/>
                    </fieldset>

                </div>


                <div class="flex flex-col md:flex-row gap-6 items-center w-full">
                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Degree requirement (*)</legend>
                        <select class="select w-full" required name="degreeRequirement">
                            <option hidden disabled>- Select degree -</option>
                            <option <c:if test="${job.degreeRequirement == 'Not required'}">selected</c:if>>Not required</option>
                            <option <c:if test="${job.degreeRequirement == 'High school education'}">selected</c:if>>High school education</option>
                            <option <c:if test="${job.degreeRequirement == 'College education'}">selected</c:if>>College education</option>
                            <option <c:if test="${job.degreeRequirement == 'University education'}">selected</c:if>>University education</option>
                            <option <c:if test="${job.degreeRequirement == 'PhD education'}">selected</c:if>>PhD education</option>
                            <option <c:if test="${job.degreeRequirement == 'Others'}">selected</c:if>>Others</option>
                            </select>
                        </fieldset>

                        <fieldset class="fieldset flex-1 w-full">
                            <legend class="fieldset-legend">Gender requirement (*)</legend>
                            <select class="select w-full" required name="genderRequirement">
                                <option hidden disabled>- Select gender -</option>
                                <option <c:if test="${job.genderRequirement == 'Not required'}">selected</c:if>>Not required</option>
                            <option <c:if test="${job.genderRequirement == 'Male'}">selected</c:if>>Male</option>
                            <option <c:if test="${job.genderRequirement == 'Female'}">selected</c:if>>Female</option>
                            <option <c:if test="${job.genderRequirement == 'LGBT Bull shit'}">selected</c:if>>LGBT Bull shit</option>
                            </select>
                        </fieldset>
                    </div>

                    <fieldset class="fieldset w-full">
                        <legend class="fieldset-legend">Status (*)</legend>
                        <select class="select w-full" required name="status">
                            <option value="open" <c:if test="${job.status == 'open'}">selected</c:if>>Open</option>
                        <option value="closed" <c:if test="${job.status == 'closed'}">selected</c:if>>Closed</option>
                        </select>
                    </fieldset>


                    <fieldset class="fieldset w-full">
                        <legend class="fieldset-legend">Job description</legend>
                        <textarea class="textarea h-36 w-full" placeholder="Enter the detailed job description" name="description" >${job.description}</textarea>
                </fieldset>
                <fieldset class="fieldset w-full">
                    <legend class="fieldset-legend">Benefits</legend>
                    <textarea class="textarea h-36 w-full" placeholder="Ex: Personal laptop, Health insurance, Team building..." name="benefits">${job.benefits}</textarea>
                </fieldset>

                <fieldset class="fieldset w-full">
                    <legend class="fieldset-legend">Required skills</legend>
                    <c:forEach var="s" items="${skillList}">
                        <label>
                            <input type="checkbox" name="skillIds" value="${s.id}"
                                   <c:forEach var="checkedId" items="${jobSkillIds}">
                                       <c:if test="${s.id == checkedId}">checked</c:if>
                                   </c:forEach>
                                   > ${s.name}
                        </label>
                        </c:forEach>

                    </fieldset>

                    <fieldset class="fieldset w-full">
                        <legend class="fieldset-legend">Other requirements</legend>
                        <textarea class="textarea h-36 w-full" placeholder="Ex: Good communication, Driver's license..." name="otherRequirements">${job.otherRequirements}</textarea>
                    </fieldset>

                    <button type="submit" class="w-full btn btn-secondary">Update Job</button>
                </form>
            </section>
        </body>

        <jsp:include page="../../components/footer.jsp"/>

    </html>