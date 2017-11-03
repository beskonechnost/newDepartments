package ua.aimprosoft.korotkov.project.web.servlet;

import org.apache.log4j.Logger;
import ua.aimprosoft.korotkov.project.dao.DaoDepartmentImpl;
import ua.aimprosoft.korotkov.project.entity.Department;
import ua.aimprosoft.korotkov.project.exception.AppException;
import ua.aimprosoft.korotkov.project.exception.DBException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by Андрей on 03.11.2017.
 */
@WebServlet("/departments")
public class DepartmentsServlet extends HttpServlet {

    private static final long serialVersionUID = 7335813713765161294L;

    private static final Logger LOG = Logger.getLogger(DepartmentsServlet.class);

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Department> departments = null;
        try {
            departments = DaoDepartmentImpl.getInstance().findDepartments();
        } catch (DBException e) {
            e.printStackTrace();
        }
        LOG.debug("departments -- > "+departments);


        String idDepartment = request.getParameter("idDepartment");
        LOG.debug("idDepartment -- > "+idDepartment);
        String flagAddNewDepartment = request.getParameter("flagAddNewDepartment");
        LOG.debug("flagAddNewDepartment -- > "+flagAddNewDepartment);
        String flagUpdateDepartment = request.getParameter("flagUpdateDepartment");
        LOG.debug("flagUpdateDepartment -- > "+flagUpdateDepartment);
        String flagDeleteDepartment = request.getParameter("flagDeleteDepartment");
        LOG.debug("flagDeleteDepartment -- > "+flagDeleteDepartment);
        String flagListEmployeesThisDepartment = request.getParameter("flagListEmployeesThisDepartment");
        LOG.debug("flagListEmployeesThisDepartment -- > "+flagListEmployeesThisDepartment);
        // Add department
        if(flagAddNewDepartment!=null){
            String nameNewDepartment = request.getParameter("nameNewDepartment");
            if(nameNewDepartment==null){
                request.setAttribute("departments", departments);
                request.setAttribute("flagAddNewDepartment", 1);
                String errorAddNewDepartment = "The value of name new department can not be empty";
                request.setAttribute("errorAddNewDepartment", errorAddNewDepartment);
            }
            ///////
            boolean uniqueNameDepartment = true;
            for(Department department : departments){
                if(department.getName().equals(nameNewDepartment)){
                    uniqueNameDepartment = false;
                    break;
                }
            }
            if(!uniqueNameDepartment){
                request.setAttribute("departments", departments);
                request.setAttribute("flagAddNewDepartment", 1);
                String errorAddNewDepartment = "The department with this name already exists in the list. Please change it";
                request.setAttribute("errorAddNewDepartment", errorAddNewDepartment);
            }
            ///////
            if(nameNewDepartment.length()<=3||nameNewDepartment.length()>45){
                request.setAttribute("departments", departments);
                request.setAttribute("flagAddNewDepartment", 1);
                String errorAddNewDepartment = "Department name can not be shorter than 3 or longer than 45 characters";
                request.setAttribute("errorAddNewDepartment", errorAddNewDepartment);
            }

        }
        request.setAttribute("departments", departments);
        request.getRequestDispatcher("/jsp/departments.jsp");


    }
}
