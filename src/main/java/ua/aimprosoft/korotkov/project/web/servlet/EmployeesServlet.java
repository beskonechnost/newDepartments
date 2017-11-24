package ua.aimprosoft.korotkov.project.web.servlet;

import org.apache.log4j.Logger;
import ua.aimprosoft.korotkov.project.dao.DaoDepartmentImpl;
import ua.aimprosoft.korotkov.project.dao.DaoEmployeeImpl;
import ua.aimprosoft.korotkov.project.entity.Department;
import ua.aimprosoft.korotkov.project.entity.Employee;
import ua.aimprosoft.korotkov.project.entity.extra.DateCheckAndParse;
import ua.aimprosoft.korotkov.project.exception.DBException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Андрей on 15.11.2017.
 */
@WebServlet("/employees")
public class EmployeesServlet extends HttpServlet {

    private static final long serialVersionUID = 5715813529465161694L;

    private static final Logger LOG = Logger.getLogger(EmployeesServlet.class);

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String departmentIdString = request.getParameter("departmentId");
        LOG.debug("departmentIdString -- > " + departmentIdString);
        List<Employee> employees = null;
        try {
            if (departmentIdString == null || departmentIdString.isEmpty()) {
                employees = DaoEmployeeImpl.getInstance().findAllEmployees();
                request.setAttribute("departments",DaoDepartmentImpl.getInstance().findDepartments());
            } else {
                employees = DaoEmployeeImpl.getInstance().findEmployeesThisDepartment(Integer.parseInt(departmentIdString));
            }
        } catch (DBException e) {
            e.printStackTrace();
        }
        LOG.debug("employees start -- > " + employees);

        String flagUpdateEmployee = request.getParameter("flagUpdateEmployee");
        LOG.debug("flagUpdateEmployee -- > " + flagUpdateEmployee);
        String flagDeleteEmployee = request.getParameter("flagDeleteEmployee");
        LOG.debug("flagDeleteEmployee -- > " + flagDeleteEmployee);

        //Error situation
        if (flagUpdateEmployee != null && flagDeleteEmployee != null) {
            LOG.error("Error some parameters");
        }
        //Add employee
        if (flagUpdateEmployee == null && flagDeleteEmployee == null) {
            Map<String, String> errorMap = checkAll(employees, null, request.getParameter("firstNameEmployee"), request.getParameter("lastNameEmployee"),
                    request.getParameter("birthdayEmployee"), request.getParameter("phoneEmployee"), request.getParameter("emailEmployee"), request.getParameter("nameDepartment"));
            LOG.debug("errorMap -- > " + errorMap);

            if (errorMap.isEmpty()) {
                try {
                    Department department = DaoDepartmentImpl.getInstance().getDepartmentByName(request.getParameter("nameDepartment"));
                    LOG.debug("department -- > " + department);
                    DaoEmployeeImpl.getInstance().addEmployee(request.getParameter("firstNameEmployee"), request.getParameter("lastNameEmployee"),
                            java.sql.Date.valueOf(request.getParameter("birthdayEmployee")), request.getParameter("phoneEmployee"), request.getParameter("emailEmployee"), department.getId());
                } catch (DBException e) {
                    e.printStackTrace();
                }
            } else {
                request.setAttribute("firstNameEmployee", request.getParameter("firstNameEmployee"));
                request.setAttribute("lastNameEmployee", request.getParameter("lastNameEmployee"));
                request.setAttribute("birthdayEmployee", request.getParameter("birthdayEmployee"));
                request.setAttribute("phoneEmployee", request.getParameter("phoneEmployee"));
                request.setAttribute("emailEmployee", request.getParameter("emailEmployee"));
                request.setAttribute("nameDepartment", request.getParameter("nameDepartment"));
                
                if ((request.getParameter("errorFlag") != null && Integer.parseInt(request.getParameter("errorFlag")) != -1) || (request.getParameter("errorFlag") == null)) {
                    request.setAttribute("errorFlag", 1);
                }
                for (Map.Entry<String, String> entry : errorMap.entrySet()) {
                    LOG.debug(entry.getKey() + "  -------->  " + entry.getValue());
                    request.setAttribute(entry.getKey(), entry.getValue());
                }
            }
        }
        //Update employee
        if (flagUpdateEmployee != null && flagDeleteEmployee == null) {
            String employeeId = request.getParameter("employeeId");
            request.setAttribute("employeeId", request.getParameter("employeeId"));
            if (request.getParameter("flagFillUpdateEmployee") != null) {
                Employee employee = null;
                try {
                    employee = DaoEmployeeImpl.getInstance().findEmployeeById(Integer.parseInt(employeeId));
                } catch (DBException e) {
                    e.printStackTrace();
                }
                LOG.debug("employee -- > " + employee);
                request.setAttribute("firstNameEmployee", employee.getFirstName());
                request.setAttribute("lastNameEmployee", employee.getLastName());
                request.setAttribute("birthdayEmployee", employee.getBirthday());
                request.setAttribute("phoneEmployee", employee.getPhone());
                request.setAttribute("emailEmployee", employee.getEmail());
                request.setAttribute("nameDepartment", request.getParameter("departmentName"));
                request.setAttribute("flagUpdateEmployee", 1);
            } else {
                Map<String, String> errorMap = checkAll(employees, employeeId, request.getParameter("firstNameEmployee"), request.getParameter("lastNameEmployee"),
                        request.getParameter("birthdayEmployee"), request.getParameter("phoneEmployee"), request.getParameter("emailEmployee"), request.getParameter("nameDepartment"));
                LOG.debug("errorMap -- > " + errorMap);

                if (errorMap.isEmpty()) {
                    try {
                        Department department = DaoDepartmentImpl.getInstance().getDepartmentByName(request.getParameter("nameDepartment"));
                        LOG.debug("department -- > " + department);
                        Employee employee = new Employee(request.getParameter("firstNameEmployee"), request.getParameter("lastNameEmployee"),
                                java.sql.Date.valueOf(request.getParameter("birthdayEmployee")), request.getParameter("phoneEmployee"), request.getParameter("emailEmployee"), department.getId());
                        employee.setId(Integer.parseInt(employeeId));
                        DaoEmployeeImpl.getInstance().updateEmployee(employee);
                    } catch (DBException e) {
                        e.printStackTrace();
                    }
                } else {
                    request.setAttribute("flagUpdateEmployee", 1);
                    request.setAttribute("firstNameEmployee", request.getParameter("firstNameEmployee"));
                    request.setAttribute("lastNameEmployee", request.getParameter("lastNameEmployee"));
                    request.setAttribute("birthdayEmployee", request.getParameter("birthdayEmployee"));
                    request.setAttribute("phoneEmployee", request.getParameter("phoneEmployee"));
                    request.setAttribute("emailEmployee", request.getParameter("emailEmployee"));
                    request.setAttribute("nameDepartment", request.getParameter("nameDepartment"));
                    if ((request.getParameter("errorFlag") != null && Integer.parseInt(request.getParameter("errorFlag")) != -1) || (request.getParameter("errorFlag") == null)) {
                        request.setAttribute("errorFlag", 1);
                    }
                    for (Map.Entry<String, String> entry : errorMap.entrySet()) {
                        LOG.debug(entry.getKey() + "  -------->  " + entry.getValue());
                        request.setAttribute(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        //Delete employee
        if (flagUpdateEmployee == null && flagDeleteEmployee != null) {
            request.setAttribute("flagDeleteEmployee", flagDeleteEmployee);
            if (Integer.parseInt(flagDeleteEmployee) == 1) {
                int idEmployee = Integer.parseInt(request.getParameter("employeeId"));
                request.setAttribute("employeeId", idEmployee);
                try {
                    Employee employee = DaoEmployeeImpl.getInstance().findEmployeeById(idEmployee);
                    request.setAttribute("employeeFirstName", employee.getFirstName());
                    request.setAttribute("employeeLastName", employee.getLastName());
                    request.setAttribute("employeeEmail", employee.getEmail());
                } catch (DBException e) {
                    e.printStackTrace();
                }
            }
            if (Integer.parseInt(flagDeleteEmployee) == 2) {
                request.setAttribute("flagDeleteEmployee", null);
                try {
                    DaoEmployeeImpl.getInstance().deleteEmployee(Integer.parseInt(request.getParameter("employeeId")));
                } catch (DBException e) {
                    e.printStackTrace();
                }


            }
        }


        try {
            if (departmentIdString == null || departmentIdString.isEmpty()) {
                employees = DaoEmployeeImpl.getInstance().findAllEmployees();
            } else {
                employees = DaoEmployeeImpl.getInstance().findEmployeesThisDepartment(Integer.parseInt(departmentIdString));
            }
        } catch (DBException e) {
            e.printStackTrace();
        }
        LOG.debug("employees end -- > " + employees);
        request.setAttribute("employees", employees);
        request.setAttribute("departmentId", request.getParameter("departmentId"));
        request.setAttribute("departmentName", request.getParameter("departmentName"));
        request.getRequestDispatcher("/WEB-INF/jsp/employees.jsp").forward(request, response);
    }


    /////////////////////////////////////////////////////
    public Map<String, String> checkAll (List<Employee> employees, String idEmployee, String firstNameEmployee, String lastNameEmployee, String birthdayEmployee,
                                         String phoneEmployee, String emailEmployee, String nameDepartment){

        Map<String, String> errorsMap = new TreeMap<String, String>();
        boolean flagErrorEmployee = false;
        int id = 0;
        if(idEmployee==null){
            id = -1;
        }else{
            id = Integer.parseInt(idEmployee);
        }

        //first name check
        if (firstNameEmployee == null) {
            errorsMap.put("errorFirstNameEmployee","Please enter the first name of the new employee!");
        } else {
            if (firstNameEmployee.length() <= 1 || firstNameEmployee.length() > 45) {
                errorsMap.put("errorFirstNameEmployee","Employee first name can not be shorter than 1 or longer than 45 characters!");
            }
        }
        //last name check
        if (lastNameEmployee == null) {
            errorsMap.put("errorLastNameEmployee","Please enter the last name of the new employee!");
        } else {
            if (lastNameEmployee.length() <= 3 || lastNameEmployee.length() > 45) {
                errorsMap.put("errorLastNameEmployee","Employee last name can not be shorter than 3 or longer than 45 characters!");
            }
        }
        //check birthday
        DateCheckAndParse dcap = DateCheckAndParse.checkAndConvertDate(birthdayEmployee);
        if(dcap.isFlagError()){
            errorsMap.put("errorBirthdayEmployee",dcap.getTextError());
        }
        //check phone
        if(phoneEmployee==null){
            errorsMap.put("errorPhoneEmployee","Please enter the phone of the new employee!");
        }else {
            String number = "(\\+)(380)([0-9]){2}(-)([0-9]){2}-[0-9]{2}-[0-9]{3}";
            Pattern p1 = Pattern.compile(number);
            Matcher m1 = p1.matcher(phoneEmployee);
            if (!m1.matches()) {
                errorsMap.put("errorPhoneEmployee", "New phone does not meet the requirements!");
            }
        }
        //check email
        if(emailEmployee==null){
            errorsMap.put("errorEmailEmployee","The value of email can not be empty!");
        }else {
            String domen1 = "[a-zA-Z][a-zA-Z[0-9]\u005F\u002E\u002D]*[a-z||0-9]";
            String domen2 = "([a-z]){2,4}";
            Pattern p = Pattern.compile(domen1 + "@" + domen1 + "\u002E" + domen2);
            Matcher m = p.matcher(emailEmployee);
            if (!m.matches()) {
                errorsMap.put("errorEmailEmployee", "New email does not meet the requirements!");
            }
        }
        boolean uniqueEmailEmployee = true;
        for(Employee employee : employees){
            if(employee.getEmail().equals(emailEmployee)){
                if(employee.getId()==id){
                    continue;
                }else {
                    uniqueEmailEmployee = false;
                    break;
                }
            }
        }
        if(!uniqueEmailEmployee){
            errorsMap.put("errorEmailEmployee","The employee with this email already exists in the list. Please change it!");
        }
        //nameDepartment
        if(nameDepartment==null || nameDepartment.isEmpty()){
            errorsMap.put("errorDepartmentEmployee","You need to choose a department!");
        }
        return errorsMap;
    }
}
