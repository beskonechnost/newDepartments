package ua.aimprosoft.korotkov.project.web.servlet;

import org.apache.log4j.Logger;
import ua.aimprosoft.korotkov.project.dao.DaoDepartmentImpl;
import ua.aimprosoft.korotkov.project.dao.DaoEmployeeImpl;
import ua.aimprosoft.korotkov.project.entity.Department;
import ua.aimprosoft.korotkov.project.exception.AppException;
import ua.aimprosoft.korotkov.project.exception.DBException;
import ua.aimprosoft.korotkov.project.exception.Messages;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
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

        List<Department> departments = new ArrayList<Department>();
        try {
            departments = DaoDepartmentImpl.getInstance().findDepartments();
        } catch (DBException e) {
            e.printStackTrace();
        }
        LOG.debug("departments start -- > "+departments);

        String flagUpdateDepartment = request.getParameter("flagUpdateDepartment");
        LOG.debug("flagUpdateDepartment -- > "+flagUpdateDepartment);
        String flagDeleteDepartment = request.getParameter("flagDeleteDepartment");
        LOG.debug("flagDeleteDepartment -- > "+flagDeleteDepartment);
        String flagListEmployee = request.getParameter("flagListEmployee");
        LOG.debug("flagListEmployee -- > "+flagListEmployee);

        // Add department
            if (flagUpdateDepartment == null && flagDeleteDepartment == null) {
                boolean flagErrorAddNewDepartment = false;
                String nameNewDepartment = request.getParameter("nameNewDepartment");
                if (nameNewDepartment == null) {
                    flagErrorAddNewDepartment = true;
                    String errorAddNewDepartment = "Please enter the name of the new department!";
                    request.setAttribute("errorAddNewDepartment", errorAddNewDepartment);
                } else {
                    if (nameNewDepartment.length() <= 3 || nameNewDepartment.length() > 45) {
                        flagErrorAddNewDepartment = true;
                        String errorAddNewDepartment = "Department name can not be shorter than 3 or longer than 45 characters";
                        request.setAttribute("errorAddNewDepartment", errorAddNewDepartment);
                    }
                }

                boolean uniqueNameDepartment = true;
                for (Department department : departments) {
                    if (department.getName().equals(nameNewDepartment)) {
                        uniqueNameDepartment = false;
                        break;
                    }
                }
                if (!uniqueNameDepartment) {
                    flagErrorAddNewDepartment = true;
                    String errorAddNewDepartment = "The department with this name already exists in the list. Please change it";
                    request.setAttribute("errorAddNewDepartment", errorAddNewDepartment);
                }

                if (flagErrorAddNewDepartment) {
                    request.setAttribute("nameNewDepartment", nameNewDepartment);
                } else {
                    Department department = new Department(nameNewDepartment);
                    try {
                        DaoDepartmentImpl.getInstance().addDepartment(department);
                        departments = DaoDepartmentImpl.getInstance().findDepartments();
                    } catch (DBException e) {
                        e.printStackTrace();
                    }
                }

            }
            //Error situation
            if (flagUpdateDepartment != null && flagDeleteDepartment != null) {
                LOG.error("Error some parameters");
            }
            //Update department
            if (flagUpdateDepartment != null && flagDeleteDepartment == null) {
                String updateDepartmentId = request.getParameter("updateDepartmentId");
                request.setAttribute("updateDepartmentId", updateDepartmentId);
                LOG.debug("updateDepartmentId -- > " + updateDepartmentId);
                String updateDepartmentName = null;
                if (request.getParameter("newNameUpdateDepartment") == null) {
                    updateDepartmentName = request.getParameter("updateDepartmentName");
                } else {
                    updateDepartmentName = request.getParameter("newNameUpdateDepartment");
                }
                request.setAttribute("updateDepartmentName", updateDepartmentName);
                LOG.debug("updateDepartmentName -- > " + updateDepartmentName);

                boolean flagErrorUpdateDepartment = false;
                if (updateDepartmentName == null) {
                    flagErrorUpdateDepartment = true;
                    String errorUpdateDepartment = "Please enter new name this department!";
                    request.setAttribute("errorUpdateDepartment", errorUpdateDepartment);
                } else {
                    if (updateDepartmentName.length() < 2 || updateDepartmentName.length() > 45) {
                        flagErrorUpdateDepartment = true;
                        String errorUpdateDepartment = "Department name can not be shorter than 2 or longer than 45 characters";
                        request.setAttribute("errorUpdateDepartment", errorUpdateDepartment);
                    }
                }

                boolean uniqueNameDepartment = true;
                for (Department department : departments) {
                    if (department.getName().equals(updateDepartmentName)) {
                        uniqueNameDepartment = false;
                        break;
                    }
                }
                if (!uniqueNameDepartment) {
                    flagErrorUpdateDepartment = true;
                    String errorUpdateDepartment = "The department with this name already exists in the list. Please change it";
                    request.setAttribute("errorUpdateDepartment", errorUpdateDepartment);
                }
                if (flagErrorUpdateDepartment) {
                    request.setAttribute("updateDepartmentName", updateDepartmentName);
                    request.setAttribute("flagUpdateDepartment", flagUpdateDepartment);
                } else {
                    Department department = new Department(Integer.parseInt(updateDepartmentId), updateDepartmentName);
                    try {
                        DaoDepartmentImpl.getInstance().updateDepartment(department);
                        departments = DaoDepartmentImpl.getInstance().findDepartments();
                    } catch (DBException e) {
                        e.printStackTrace();
                    }
                }
            }
            //Delete department
            if (flagUpdateDepartment == null && flagDeleteDepartment != null) {
                request.setAttribute("flagDeleteDepartment", flagDeleteDepartment);
                if (Integer.parseInt(flagDeleteDepartment) == 1) {
                    request.setAttribute("deleteDepartmentId", request.getParameter("deleteDepartmentId"));
                    LOG.debug("deleteDepartmentId -- > " + request.getParameter("deleteDepartmentId"));
                    request.setAttribute("deleteDepartmentName", request.getParameter("deleteDepartmentName"));
                    LOG.debug("deleteDepartmentName -- > " + request.getParameter("deleteDepartmentName"));
                }
                if (Integer.parseInt(flagDeleteDepartment) == 2) {
                    request.setAttribute("flagDeleteDepartment", null);
                    try {
                        DaoDepartmentImpl.getInstance().deleteDepartmentAndAllItsEmployees(Integer.parseInt(request.getParameter("deleteDepartmentId")));
                        departments = DaoDepartmentImpl.getInstance().findDepartments();
                    } catch (DBException e) {
                        e.printStackTrace();
                    }
                }

            }
            LOG.debug("departments end -- > " + departments);
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("/WEB-INF/jsp/departments.jsp").forward(request, response);
    }
}
