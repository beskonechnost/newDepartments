<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<title>Departments</title>
<body>
<a href="/departments">All departments</a>
<table id="main-container">

    <tr>
        <td>
            <form>
                <table border="1">
                    <thead>
                    <tr>
                        <td>Name department</td>
                        <td>List employees</td>
                        <td>Update department</td>
                        <td>Delete department</td>
                    </tr>
                    </thead>

                    <c:forEach var="item" items="${departments}" begin="0">
                        <tr>
                            <td>${item.name}</td>
                            <td>
                                <form action="/employees" method="post">
                                    <input type="hidden" name="departmentId" value="${item.id}" />
                                    <input type="hidden" name="departmentName" value="${item.name}" />
                                    <input type="hidden" name="errorFlag" value="${-1}" />
                                    <input type="submit" value="List">
                                </form>
                            </td>
                            <td>
                                <form action="/departments">
                                    <input type="hidden" name="updateDepartmentId" value="${item.id}" />
                                    <input type="hidden" name="updateDepartmentName" value="${item.name}" />
                                    <input type="hidden" name="flagUpdateDepartment" value="${1}" />
                                    <input type="submit" value="Update">
                                </form>
                            </td>
                            <td>
                                <form action="/departments">
                                    <input type="hidden" name="deleteDepartmentId" value="${item.id}" />
                                    <input type="hidden" name="deleteDepartmentName" value="${item.name}" />
                                    <input type="hidden" name="flagDeleteDepartment" value="${1}" />
                                    <input type="submit" value="Delete">
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </form>
        </td>
        <td class="content">
            <c:if test="${flagUpdateDepartment!=1}">
                <c:if test="${flagDeleteDepartment!=1}">
                    <fieldset >
                    <legend>Add new department</legend>
                    <form id="add_form" action="/departments">
                        <b><font size="5" color="red" face="Arial">${errorAddNewDepartment}</font></b><br>
                        <div>
                            <b>Enter the name of a new department: </b>
                            <input name="nameNewDepartment" value="<c:out value="${nameNewDepartment}"></c:out>">
                        </div>
                        <input type="submit" value="Add New Department"><br/>
                    </form>
                    </fieldset><br>
                </c:if>
            </c:if>

            <c:if test="${flagDeleteDepartment==1}">
            <fieldset >
                <legend>Delete ${deleteDepartmentName} department</legend>
                <form id="delete_form" action="/departments">
                    <input type="hidden" name="deleteDepartmentId" value="${deleteDepartmentId}" />
                    <input type="hidden" name="deleteDepartmentName" value="${deleteDepartmentName}" />
                    <input type="hidden" name="flagDeleteDepartment" value="${2}" />
                    <p><b>Are you sure you want to delete "${deleteDepartmentName}" department and all its employees?</b></p>
                    <input type="submit" value="Delete">
                </form>
            </fieldset>
            </c:if>

            <c:if test="${flagUpdateDepartment==1}">
            <fieldset >
                <legend>Update department</legend>
                <form id="update_form" action="/departments">
                    <input type="hidden" name="updateDepartmentId" value="${updateDepartmentId}" />
                    <input type="hidden" name="updateDepartmentName" value="${updateDepartmentName}" />
                    <input type="hidden" name="flagUpdateDepartment" value="${1}" />

                    <div>
                        <b>Enter a new name this department:</b>
                        <input name="newNameUpdateDepartment" value="<c:out value="${updateDepartmentName}"></c:out>">
                    </div>
                    <b><font size="5" color="red" face="Arial">${errorUpdateDepartment}</font></b><br>
                    <input type="submit" value="Update"><br/>
                </form>
            </fieldset>
            </c:if>
        </td>
    </tr>

</table>
</body>
</html>