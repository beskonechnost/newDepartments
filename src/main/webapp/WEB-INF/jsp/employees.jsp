<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<c:set var="title" value="Employees" scope="page" />
<link rel="stylesheet" href="../../style/style.css">
<body>
<div class="bg"></div>
    <div class="links">
        <a href="/departments">All departments</a>
        <a href="/employees?errorFlag=-1">All employees</a>
    </div>

    <div class="links">
        <c:if test="${departmentName==null}">
            <b class="element_label_text">All employees of all departments:</b>
        </c:if>
        <c:if test="${departmentName!=null}">
            <b class="element_label_text">Employees ${departmentName}:</b>
        </c:if>
    </div>

    <div class="box">
      <form>
          <c:if test="${employees.isEmpty()}">
              </br><b class="element_label_text">In this department, not a single employee!</b>
          </c:if>
          <c:if test="${!employees.isEmpty()}">
        <table border="1">
          <thead>
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Birthday</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Update</th>
            <th>Delete</th>
          </tr>
          </thead>

          <c:forEach var="item" items="${employees}" begin="0">
            <tr>
              <td class="element_table_text">${item.firstName}</td>
              <td class="element_table_text">${item.lastName}</td>
              <td class="element_table_text">${item.birthday}</td>
              <td class="element_table_text">${item.phone}</td>
              <td class="element_table_text">${item.email}</td>
              <td>
                    <form class="center_button" action="/employees">
                        <input type="hidden" name="departmentId" value="${departmentId}" />
                        <input type="hidden" name="departmentName" value="${departmentName}" />
                        <input type="hidden" name="employeeId" value="${item.id}" />
                        <input type="hidden" name="flagFillUpdateEmployee" value="${1}" />
                        <input type="hidden" name="flagUpdateEmployee" value="${1}" />
                        <input class="center_button_style" type="submit" value="Update">
                    </form>
              </td>
              <td>
                    <form class="center_button" action="/employees">
                        <input type="hidden" name="departmentId" value="${departmentId}" />
                        <input type="hidden" name="departmentName" value="${departmentName}" />
                        <input type="hidden" name="employeeId" value="${item.id}" />
                        <input type="hidden" name="flagDeleteEmployee" value="${1}" />
                        <input class="center_button_style" type="submit" value="Delete">
                    </form>
              </td>
            </tr>
          </c:forEach>
        </table>
          </c:if>
      </form>
    </div>
    <div class="box">
          <c:if test="${flagUpdateEmployee!=1}">
              <c:if test="${flagDeleteEmployee!=1}">
              <fieldset >
                  <legend>Add employee:</legend>
                  <form action="/employees" method="post">
                      <input type="hidden" name="departmentId" value="${departmentId}" />
                      <input type="hidden" name="departmentName" value="${departmentName}" />

                      <div>
                        <c:if test="${errorFlag==1}">
                          <b class="error_text">${errorFirstNameEmployee}</b><br>
                        </c:if>
                          <b class="element_label_text">First name:</b>
                          <input type="text" name="firstNameEmployee" value="<c:out value="${firstNameEmployee}"></c:out>">
                      </div></br>

                      <div>
                        <c:if test="${errorFlag==1}">
                          <b class="error_text">${errorLastNameEmployee}</b><br>
                        </c:if>
                          <b class="element_label_text">Last name:</b>
                          <input type="text" name="lastNameEmployee" value="<c:out value="${lastNameEmployee}"></c:out>">
                      </div></br>

                      <div>
                        <c:if test="${errorFlag==1}">
                          <b class="error_text">${errorBirthdayEmployee}</b><br>
                        </c:if>
                          <b class="element_label_text">Birthday:</b>
                          <input type="date" name="birthdayEmployee" value="<c:out value="${birthdayEmployee}"></c:out>">
                      </div></br>

                      <div>
                        <c:if test="${errorFlag==1}">
                          <b class="error_text">${errorPhoneEmployee}</b><br>
                        </c:if>
                          <b class="element_label_text">Phone (in format +380XX-XX-XX-XXX ):</b>
                          <input type="tel" name="phoneEmployee" pattern="+380[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{3}" value="<c:out value="${phoneEmployee}"></c:out>">
                      </div></br>

                      <div>
                        <c:if test="${errorFlag==1}">
                          <b class="error_text">${errorEmailEmployee}</b><br>
                        </c:if>
                          <b class="element_label_text">Email:</b>
                          <input type="email" name="emailEmployee"  value="<c:out value="${emailEmployee}"></c:out>">
                      </div></br>

                      <c:if test="${departmentId>0}">
                          <div>
                              <b class="element_label_text">Department - ${departmentName}</b>
                              <input type="hidden" name="nameDepartment" value="<c:out value="${departmentName}"></c:out>">
                          </div></br>
                      </c:if>
                      <c:if test="${departmentId==null || departmentId==0 || departmentId.isEmpty()}">
                          <div>
                          <c:if test="${errorFlag==1}">
                              <b class="error_text">${errorDepartmentEmployee}</b><br>
                          </c:if>
                              <b class="element_label_text">Select the desired department:</b>
                              <select class="styled-select" name="nameDepartment">
                                      <c:forEach var="departments" items="${departments}" begin="0">
                                          <c:if test="${departments.name==nameDepartment}">
                                              <option selected value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                          </c:if>
                                          <option value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                      </c:forEach>
                              </select>
                          </div></br>
                      </c:if>
                      <input class="center_button_style" type="submit" value="Add"><br/>
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
                          <p><b class="element_label_text">Are you sure you want to delete ${employeeFirstName} ${employeeLastName} employee?</br>
                                (Email employee - ${employeeEmail})</b></p>
                          <input class="center_button_style" type="submit" value="Delete">
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
                              <b class="error_text">${errorFirstNameEmployee}</b><br>
                          </c:if>
                          <b class="element_label_text">Enter a new employee first name:</b>
                          <input type="text" name="firstNameEmployee" value="<c:out value="${firstNameEmployee}"></c:out>">
                      </div></br>

                      <div>
                          <c:if test="${errorFlag==1}">
                              <b class="error_text">${errorLastNameEmployee}</b><br>
                          </c:if>
                          <b class="element_label_text">Enter a new employee last name:</b>
                          <input type="text" name="lastNameEmployee" value="<c:out value="${lastNameEmployee}"></c:out>">
                      </div></br>

                      <div>
                          <c:if test="${errorFlag==1}">
                              <b class="error_text">${errorBirthdayEmployee}</b><br>
                          </c:if>
                          <b class="element_label_text">Enter a new employee birthday:</b>
                          <input type="date" name="birthdayEmployee" value="<c:out value="${birthdayEmployee}"></c:out>">
                      </div></br>

                      <div>
                          <c:if test="${errorFlag==1}">
                              <b class="error_text">${errorPhoneEmployee}</b><br>
                          </c:if>
                          <b class="element_label_text">Enter a new employee phone (in format +380XX-XX-XX-XXX):</b>
                          <input type="tel" name="phoneEmployee" pattern="+380[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{3}" value="<c:out value="${phoneEmployee}"></c:out>">
                      </div></br>

                      <div>
                          <c:if test="${errorFlag==1}">
                              <b class="error_text">${errorEmailEmployee}</b><br>
                          </c:if>
                          <b class="element_label_text">Enter a new employee email:</b>
                          <input type="email" name="emailEmployee"  value="<c:out value="${emailEmployee}"></c:out>">
                      </div></br>

                      <div>
                          <c:if test="${errorFlag==1}">
                              <b class="error_text">${errorDepartmentEmployee}</b><br>
                          </c:if>
                          <b class="element_label_text">Select the desired department:</b>
                              <select class="styled-select" name="nameDepartment">
                                  <c:if test="${nameDepartment!=null}">
                                      <c:forEach var="departments" items="${departments}" begin="0">
                                          <c:if test="${departments.name==nameDepartment}">
                                              <option selected value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                          </c:if>
                                          <c:if test="${departments.name!=nameDepartment}">
                                          <option value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                          </c:if>
                                      </c:forEach>
                                  </c:if>
                                  <c:if test="${nameDepartment==null}">
                                      <option value="<c:out value=""/>"><c:out value=""/></option>
                                      <c:forEach var="departments" items="${departments}" begin="0">
                                          <option value="<c:out value="${departments.name}"/>"><c:out value="${departments.name}"/></option>
                                      </c:forEach>
                                  </c:if>
                              </select>
                      </div></br>

                      <input class="center_button_style" type="submit" value="Update"><br/>
                  </form>
              </fieldset>
          </c:if>
    </div>
</body>
</html>