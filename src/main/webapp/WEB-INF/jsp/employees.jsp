<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<c:set var="title" value="Employees" scope="page" />
<body>
<a href="/departments">All departments</a>
<a href="/employees?errorFlag=-1">All employees</a>
<table id="main-container">

  <tr>
    <td class="content">
          <div>
                <c:if test="${departmentName==null}">
                    <b>All employees of all departments:</b>
                </c:if>
                <c:if test="${departmentName!=null}">
                    <b>Employees "${departmentName}":</b>
                </c:if>
          </div>

      <form>
          <c:if test="${employees.isEmpty()}">
              <b>In this department, not a single employee!</b>
          </c:if>
          <c:if test="${!employees.isEmpty()}">
        <table border="1">
          <thead>
          <tr>
            <td>First Name</td>
            <td>Last Name</td>
            <td>Birthday</td>
            <td>Phone</td>
            <td>Email</td>
            <td>Update</td>
            <td>Delete</td>
          </tr>
          </thead>

          <c:forEach var="item" items="${employees}" begin="0">
            <tr>
              <td>${item.firstName}</td>
              <td>${item.lastName}</td>
              <td>${item.birthday}</td>
              <td>${item.phone}</td>
              <td>${item.email}</td>
              <td>
                    <form action="/employees">
                        <input type="hidden" name="departmentId" value="${departmentId}" />
                        <input type="hidden" name="departmentName" value="${departmentName}" />
                        <input type="hidden" name="employeeId" value="${item.id}" />
                        <input type="hidden" name="flagFillUpdateEmployee" value="${1}" />
                        <input type="hidden" name="flagUpdateEmployee" value="${1}" />
                        <input type="submit" value="Update">
                    </form>
              </td>
              <td>
                    <form action="/employees">
                        <input type="hidden" name="departmentId" value="${departmentId}" />
                        <input type="hidden" name="departmentName" value="${departmentName}" />
                        <input type="hidden" name="employeeId" value="${item.id}" />
                        <input type="hidden" name="flagDeleteEmployee" value="${1}" />
                        <input type="submit" value="Delete">
                    </form>
              </td>
            </tr>
          </c:forEach>
        </table>
          </c:if>
      </form>
    </td>

    <td class="content">
          <c:if test="${flagUpdateEmployee!=1}">
              <c:if test="${flagDeleteEmployee!=1}">
              <fieldset >
                  <legend>Add employee:</legend>
                  <form action="/employees" method="post">
                      <input type="hidden" name="departmentId" value="${departmentId}" />
                      <input type="hidden" name="departmentName" value="${departmentName}" />

                      <div>
                        <c:if test="${errorFlag==1}">
                          <b><font size="1" color="red" face="Arial">${errorFirstNameEmployee}</font></b><br>
                        </c:if>
                          <b>First name:</b>
                          <input name="firstNameEmployee" value="<c:out value="${firstNameEmployee}"></c:out>">
                      </div>

                      <div>
                        <c:if test="${errorFlag==1}">
                          <b><font size="1" color="red" face="Arial">${errorLastNameEmployee}</font></b><br>
                        </c:if>
                          <b>Last name:</b>
                          <input name="lastNameEmployee" value="<c:out value="${lastNameEmployee}"></c:out>">
                      </div>

                      <div>
                        <c:if test="${errorFlag==1}">
                          <b><font size="1" color="red" face="Arial">${errorBirthdayEmployee}</font></b><br>
                        </c:if>
                          <b>Birthday:</b>
                          <input type="date" name="birthdayEmployee" value="<c:out value="${birthdayEmployee}"></c:out>">
                      </div>

                      <div>
                        <c:if test="${errorFlag==1}">
                          <b><font size="1" color="red" face="Arial">${errorPhoneEmployee}</font></b><br>
                        </c:if>
                          <b>Phone (in format +380XX-XX-XX-XXX ):</b>
                          <input type="tel" name="phoneEmployee" pattern="+380[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{3}" value="<c:out value="${phoneEmployee}"></c:out>">
                      </div>

                      <div>
                        <c:if test="${errorFlag==1}">
                          <b><font size="1" color="red" face="Arial">${errorEmailEmployee}</font></b><br>
                        </c:if>
                          <b>Email:</b>
                          <input type="email" name="emailEmployee"  value="<c:out value="${emailEmployee}"></c:out>">
                      </div>

                      <c:if test="${departmentId>0}">
                          <div>
                              <b>Department - ${departmentName}</b>
                              <input type="hidden" name="nameDepartment" value="<c:out value="${nameDepartment}"></c:out>">
                          </div>
                      </c:if>
                      <c:if test="${departmentId==null || departmentId==0 || departmentId.isEmpty()}">
                          <div>
                          <c:if test="${errorFlag==1}">
                              <b><font size="1" color="red" face="Arial">${errorDepartmentEmployee}</font></b><br>
                          </c:if>
                              <b>Select the desired department:</b>
                              <select name="nameDepartment">
                                  <c:if test="${nameDepartment!=null || nameDepartment!=0 || !nameDepartment.isEmpty()}">
                                      <c:forEach var="departments" items="${departments}" begin="0">
                                          <c:if test="${departments.name==nameDepartment}">
                                              <option selected value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                          </c:if>
                                          <option value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                      </c:forEach>
                                  </c:if>
                                  <c:if test="${nameDepartment==null || nameDepartment==0 || nameDepartment.isEmpty()}">
                                      <option selected value="<c:out value=""/>"><c:out value=""/></option>
                                      <c:forEach var="departments" items="${departments}" begin="0">
                                          <option value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                      </c:forEach>
                                  </c:if>
                              </select>
                          </div>
                      </c:if>
                      <input type="submit" value="Add"><br/>
                  </form>
              </fieldset>
              </c:if>
              <c:if test="${flagDeleteEmployee==1}">
                  <!-- visualization removal employee -->
                  <fieldset >
                      <legend>Delete employee</legend>
                      <form action="/employees">
                          <input type="hidden" name="departmentId" value="${departmentId}" />
                          <input type="hidden" name="departmentName" value="${departmentName}" />
                          <input type="hidden" name="employeeId" value="${employeeId}" />
                          <input type="hidden" name="flagDeleteEmployee" value="${2}" />
                          <p><b>Are you sure you want to delete ${employeeFirstName} ${employeeLastName} employee?</br>
                                (Email employee - ${employeeEmail})</b></p>
                          <input type="submit" value="Delete">
                      </form>
                  </fieldset>
              </c:if>
          </c:if>

          <c:if test="${flagUpdateEmployee==1}">
              <fieldset >
                  <legend>Update employee:</legend>
                  <form action="/employees" method="post">
                      <input type="hidden" name="departmentId" value="${departmentId}" />
                      <input type="hidden" name="departmentName" value="${departmentName}" />
                      <input type="hidden" name="employeeId" value="${employeeId}" />
                      <input type="hidden" name="flagUpdateEmployee" value="${1}" />

                      <div>
                          <c:if test="${errorFlag==1}">
                              <b><font size="1" color="red" face="Arial">${errorFirstNameEmployee}</font></b><br>
                          </c:if>
                          <p>Enter a new employee first name:</p>
                          <input name="firstNameEmployee" value="<c:out value="${firstNameEmployee}"></c:out>">
                      </div>

                      <div>
                          <c:if test="${errorFlag==1}">
                              <b><font size="1" color="red" face="Arial">${errorLastNameEmployee}</font></b><br>
                          </c:if>
                          <p>Enter a new employee last name:</p>
                          <input name="lastNameEmployee" value="<c:out value="${lastNameEmployee}"></c:out>">
                      </div>

                      <div>
                          <c:if test="${errorFlag==1}">
                              <b><font size="1" color="red" face="Arial">${errorBirthdayEmployee}</font></b><br>
                          </c:if>
                          <p>Enter a new employee birthday:</p>
                          <input type="date" name="birthdayEmployee" value="<c:out value="${birthdayEmployee}"></c:out>">
                      </div>

                      <div>
                          <c:if test="${errorFlag==1}">
                              <b><font size="1" color="red" face="Arial">${errorPhoneEmployee}</font></b><br>
                          </c:if>
                          <p>Enter a new employee phone (in format +380XX-XX-XX-XXX):</p>
                          <input type="tel" name="phoneEmployee" pattern="+380[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{3}" value="<c:out value="${phoneEmployee}"></c:out>">
                      </div>

                      <div>
                          <c:if test="${errorFlag==1}">
                              <b><font size="1" color="red" face="Arial">${errorEmailEmployee}</font></b><br>
                          </c:if>
                          <p>Enter a new employee email:</p>
                          <input type="email" name="emailEmployee"  value="<c:out value="${emailEmployee}"></c:out>">
                      </div>

                      <c:if test="${departmentId>0}">
                          <div>
                              <b>Department - ${departmentName}</b>
                              <input type="hidden" name="nameDepartment" value="<c:out value="${departmentName}"></c:out>">
                          </div>
                      </c:if>
                      <c:if test="${departmentId==0}">
                          <div>
                              <c:if test="${errorFlag==1}">
                                  <b><font size="1" color="red" face="Arial">${errorDepartmentEmployee}</font></b><br>
                              </c:if>
                              <p>Select the desired department:</p>
                              <select name="nameDepartment">
                                  <c:if test="${nameDepartment!=null}">
                                      <c:forEach var="departments" items="${departments}" begin="0">
                                          <c:if test="${departments.name==nameDepartment}">
                                              <option selected value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                          </c:if>
                                          <option value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                      </c:forEach>
                                  </c:if>
                                  <c:if test="${nameDepartment==null}">
                                      <option value="<c:out value=""/>"><c:out value=""/></option>
                                      <c:forEach var="departments" items="${departments}" begin="0">
                                          <option value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                      </c:forEach>
                                  </c:if>
                              </select>
                          </div>
                      </c:if>

                      <input type="submit" value="Update"><br/>
                  </form>
              </fieldset>
          </c:if>
    </td>
  </tr>

</table>
</body>
</html>