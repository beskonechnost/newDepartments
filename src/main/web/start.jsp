<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>

<c:set var="title" value="Start" />
<link rel="stylesheet" type="text/css" media="screen" href="style/style.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<table id="main-container">
  <tr >
    <td class="content center">
      <form id="start_form" action="DepartmentsServlet" method="post">
        <input type="hidden" name="command" value="AllDepartments"/>
        <fieldset >
          <legend>WELCOME</legend>
          <H1><b>Welcome to my test application<br/>
            The application is open and does not require authorization.<br/></b></H1>
        </fieldset><br/>
        <input type="submit" value="Come in">
      </form>
    </td>
  </tr>
  <tr>
    <td id="footer">Departments for Aimprosoft, from Korotkov Andrey</td>
  </tr>

</table>
</body>
</html>
