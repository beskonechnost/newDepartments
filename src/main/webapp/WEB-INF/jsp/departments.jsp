<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<title>Departments</title>
<link rel="stylesheet" href="../../style/style.css">
<body>
<div class="links">
    <a href="/departments">All departments</a>
    <a href="/employees?errorFlag=-1">All employees</a>
</div>
    <div class="box">
                <table border="1">
                    <thead>
                    <tr>
                        <th>Name department</th>
                        <th>List employees</th>
                        <th>Update department</th>
                        <th>Delete department</th>
                    </tr>
                    </thead>

                    <c:forEach var="item" items="${departments}" begin="0">
                        <tr>
                            <td class="element_table_text">${item.name}</td>
                            <td>
                                <form class="center_button" action="/employees" method="post">
                                    <input type="hidden" name="departmentId" value="${item.id}" />
                                    <input type="hidden" name="departmentName" value="${item.name}" />
                                    <input type="hidden" name="errorFlag" value="${-1}" />
                                    <input class="center_button_style" type="submit" value="List">
                                </form>
                            </td>
                            <td>
                                <form class="center_button" action="/departments">
                                    <input type="hidden" name="updateDepartmentId" value="${item.id}" />
                                    <input type="hidden" name="updateDepartmentName" value="${item.name}" />
                                    <input type="hidden" name="flagUpdateDepartment" value="${1}" />
                                    <input class="center_button_style" type="submit" value="Update">
                                </form>
                            </td>
                            <td>
                                <form class="center_button" action="/departments">
                                    <input type="hidden" name="deleteDepartmentId" value="${item.id}" />
                                    <input type="hidden" name="deleteDepartmentName" value="${item.name}" />
                                    <input type="hidden" name="flagDeleteDepartment" value="${1}" />
                                    <input class="center_button_style" type="submit" value="Delete">
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
    </div>
    <div class="box">
            <c:if test="${flagUpdateDepartment!=1}">
                <c:if test="${flagDeleteDepartment!=1}">
                    <fieldset>
                    <legend>Add new department</legend>
                    <form id="add_form" action="/departments">
                        <div>
                            <c:if test="${errorFlag==1}">
                                <b class="error_text">${errorAddNewDepartment}</b><br>
                            </c:if>
                            <b class="element_label_text">Enter the name of a new department: </b>
                            <input type="text" name="nameNewDepartment" value="<c:out value="${nameNewDepartment}"></c:out>">
                        </div></br>
                        <input class="center_button_style" type="submit" value="Add New Department"><br/>
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
                    <p><b class="element_label_text">Are you sure you want to delete "${deleteDepartmentName}" department and all its employees?</b></p>
                    <input class="center_button_style" type="submit" value="Delete">
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
                        <c:if test="${errorFlag==1}">
                            <b class="error_text">${errorUpdateDepartment}</b><br>
                        </c:if>
                        <b class="element_label_text">Enter a new name this department:</b>
                        <input type="text" name="newNameUpdateDepartment" value="<c:out value="${updateDepartmentName}"></c:out>">
                    </div></br>
                    <input class="center_button_style" type="submit" value="Update"><br/>
                </form>
            </fieldset>
            </c:if>
    </div>

</body>
</html>