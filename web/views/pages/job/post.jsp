
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

    <body>
        <section class="max-w-lg md:max-w-3xl mx-auto my-36 grid place-content-center">


            <form action="PostJob" method="post" class="min-w-sm md:min-w-xl flex flex-col items-center justify-center gap-6">
                <h1 class="text-xl md:text-3xl font-bold">Post a Job</h1>

                <c:if test="${not empty error }">
                    <div role="alert" class="alert ${param.alert} alert-error w-full h-12 text-center" id="message">
                        <c:if test="${not empty error}">${error}</c:if>
                        </div>
                </c:if>



                <fieldset class="fieldset w-full">
                    <legend class="fieldset-legend">Job title (*)</legend>
                    <input type="text" class="input w-full" placeholder="My awesome page" name="title" required
                           oninvalid="this.setCustomValidity('Please enter Job title')"
                           oninput="this.setCustomValidity('')"/>
                </fieldset>



                <div class="flex flex-col md:flex-row gap-6 items-center w-full">

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Category (*)</legend>
                        <select class="select w-full" name="categoryId"  
                                oninvalid="this.setCustomValidity('Please select Catergory')"
                                oninput="this.setCustomValidity('')"/>
                        <option value="" hidden disabled selected>- Select category -</option>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>
                                ${cat.name}
                            </option>
                        </c:forEach>
                        </select>
                    </fieldset>

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Minium Salaries</legend>
                        <input type="number" class="input w-full validator" min="100" placeholder="Ex: $1000 - $1500" name="salary"/>
                    </fieldset>



                </div>

                <div class="flex flex-col md:flex-row gap-6 items-center w-full">

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Location (*)</legend>
                        <input type="text" class="input w-full validator" placeholder="Ex: Hanoi, Ho Chi Minh City" name="location" required
                               oninvalid="this.setCustomValidity('Please enter Location')"
                               oninput="this.setCustomValidity('')"/>
                    </fieldset>

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">End date (*)</legend>
                        <input type="date" class="input validator w-full" required placeholder="Pick a date from 2025" 
                               min="2025-01-01"
                               title="Must be valid date" name="endDate" />
                    </fieldset>



                </div>


                <div class="flex flex-col md:flex-row gap-6 items-center w-full">

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Working hours</legend>
                        <input type="text" class="input w-full validator" placeholder="Ex: Office hours (Monday - Friday)" name="workingHours"/>
                    </fieldset>

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Experience level (*)</legend>
                        <select class="select w-full" name="experienceLevel" required>
                            <option hidden disabled selected>- Select level -</option>
                            <option>Not required</option>
                            <option>Fresher</option>
                            <option>Junior</option>
                            <option>Senior</option>
                        </select>
                    </fieldset>





                </div>

                <div class="flex flex-col md:flex-row gap-6 items-center w-full">

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Min age</legend>
                        <input type="number" class="input validator w-full" placeholder="Leave blank if not required" 
                               min="18"
                               max="49"
                               title="Minium 18 years old" name="minAge"/>
                    </fieldset>

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Max age</legend>
                        <input type="number" class="input validator w-full" placeholder="Leave blank if not required"
                               min="18"
                               max="50"
                               title="Maxium 50 years old" name="maxAge"/>
                    </fieldset>

                </div>


                <div class="flex flex-col md:flex-row gap-6 items-center w-full">
                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Degree requirement (*)</legend>
                        <select class="select w-full" required name="degreeRequirement">
                            <option hidden disabled selected>- Select degree -</option>
                            <option>Not required</option>
                            <option>High school education</option>
                            <option>College education</option>
                            <option>University education</option>
                            <option>PhD education</option>
                            <option>Others</option>
                        </select>
                    </fieldset>

                    <fieldset class="fieldset flex-1 w-full">
                        <legend class="fieldset-legend">Gender requirement (*)</legend>
                        <select class="select w-full" required name="genderRequirement">
                            <option hidden disabled selected>- Select gender -</option>
                            <option>Not required</option>
                            <option>Male</option>
                            <option>Female</option>
                            <option>LGBT Bull shit</option>
                        </select>
                    </fieldset>

                </div>

                <fieldset class="fieldset w-full">
                    <legend class="fieldset-legend">Job description</legend>
                    <textarea class="textarea h-36 w-full" placeholder="Enter the detailed job description" name="description" ></textarea>
                </fieldset>
                <fieldset class="fieldset w-full">
                    <legend class="fieldset-legend">Benefits</legend>
                    <textarea class="textarea h-36 w-full" placeholder="Ex: Personal laptop, Health insurance, Team building..." name="benefits"></textarea>
                </fieldset>

                <fieldset class="fieldset w-full">
                    <legend class="fieldset-legend">Required skills</legend>
                    <c:forEach var="s" items="${skillList}">
                        <label>
                            <input type="checkbox" name="skillIds" value="${s.id}"> ${s.name}
                        </label>
                    </c:forEach>
                </fieldset>

                <fieldset class="fieldset w-full">
                    <legend class="fieldset-legend">Other requirements</legend>
                    <textarea class="textarea h-36 w-full" placeholder="Ex: Good communication, Driver's license..." name="otherRequirements"></textarea>
                </fieldset>
                <button type="submit" class="w-full btn btn-secondary">Post</button>
            </form>
        </section>
    </body>


    <jsp:include page="../../components/footer.jsp"/>

</html>
