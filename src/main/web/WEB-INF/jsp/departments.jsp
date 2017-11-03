<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>

<c:set var="title" value="Departments" scope="page" />
<link rel="stylesheet" type="text/css" media="screen" href="style/style.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<body>
<table id="main-container">

    <tr>
        <td>
            <%-- CONTENT --%>

            <form action="DepartmentsServlet">
                <table id="list_departments_table">
                    <thead>
                    <tr>
                        <td>№</td>
                        <td>Name department</td>
                        <td>List employees</td>
                        <td>Update department</td>
                        <td>Delete department</td>
                    </tr>
                    </thead>

                    <c:set var="k" value="0"/>
                    <c:forEach var="item" items="${departments}">
                        <c:set var="k" value="${k+1}"/>
                        <tr>
                            <td>${k}</td>
                            <td>${item.name}</td>
                            <td>
                                <form action="controller" method="post">
                                    <input type="hidden" name="departmentId" value="${item.id}" />
                                    <input type="hidden" name="departmentName" value="${item.name}" />
                                    <input type="hidden" name="command" value="ListEmployees" />
                                    <input type="submit" value="List">
                                </form>
                            </td>
                            <td>
                                <form action="controller" method="post">
                                    <input type="hidden" name="departmentId" value="${item.id}" />
                                    <input type="hidden" name="visibleUpdateDepartment" value="${1}" />
                                    <input type="hidden" name="command" value="AllDepartments" />
                                    <input type="submit" value="Update">
                                </form>
                            </td>
                            <td>
                                <form action="controller" method="post">
                                    <input type="hidden" name="itemId" value="${item.id}" />
                                    <input type="hidden" name="itemName" value="${item.name}" />
                                    <input type="hidden" name="command" value="RemovalConfirmationDepartment" />
                                    <input type="submit" value="Delete">
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </form>
        </td>
        <td class="content">
            <c:if test="${visibleUpdateDepartment!=1}">
            <fieldset >
                <legend>Add new department</legend>
                <form id="add_form" action="controller" method="post">
                    <input type="hidden" name="command" value="AddDepartment" />

                    <div>
                        <b>Enter the name of a new department: </b>
                        <input name="nameNewDepartment" value="<c:out value=""></c:out> ">
                    </div>
                    <b><font size="5" color="red" face="Arial">${errorAddNewDepartment}</font></b><br>
                    <input type="submit" value="Add New Department"><br/>
                </form>
            </fieldset><br>
            </c:if>
            <c:if test="${visibleUpdateDepartment==1}">
            <fieldset >
                <legend>Update department</legend>
                <form id="update_form" action="controller" method="post">
                    <input type="hidden" name="command" value="UpdateDepartmentForm" />
                    <input type="hidden" name="id" value="${updateDepartmentId}" />
                    <input type="hidden" name="oldName" value="${updateDepartmentName}" />
                    <input type="hidden" name="visibleUpdateDepartment" value="${1}" />

                    <div>
                        <b>Enter a new department name:</b>
                        <input name="name" value="<c:out value="${updateDepartmentName}"></c:out>">
                    </div>
                    <b><font size="5" color="red" face="Arial">${errorUpdateDepartment}</font></b><br>
                    <input type="hidden" name="departmentId" value="${0}" />
                    <input type="submit" value="Update"><br/>
                </form>
            </fieldset>
            </c:if>
        </td>
    </tr>

</table>
</body>
</html>