package ua.aimprosoft.korotkov.project.dao;

import ua.aimprosoft.korotkov.project.entity.Employee;
import ua.aimprosoft.korotkov.project.exception.DBException;

import java.sql.Date;
import java.util.List;

public interface DaoEmployee {

    public List<Employee> findAllEmployees() throws DBException;
    public List<Employee> findEmployeesThisDepartment(int idDepartment) throws DBException;
    public Employee findEmployeeById(int idEmployee)throws DBException;
    public void addEmployee(String firstName, String lastName, Date date, String phone, String mail, int idDep) throws DBException;
    public void updateEmployee(Employee employee) throws DBException;
    public void deleteEmployee(int id) throws DBException;


}
