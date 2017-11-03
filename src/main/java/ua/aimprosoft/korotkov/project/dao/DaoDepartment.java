package ua.aimprosoft.korotkov.project.dao;

import ua.aimprosoft.korotkov.project.entity.Department;
import ua.aimprosoft.korotkov.project.exception.DBException;

import java.util.List;

public interface DaoDepartment {

    public List<Department> findDepartments() throws DBException;
    public void updateDepartment(Department department) throws DBException;
    public void deleteDepartmentAndAllItsEmployees(int idDepartment) throws DBException;
    public void addDepartment(Department department) throws DBException;
    public Department getDepartmentByName(String name) throws DBException;
    public Department getDepartmentById(int id) throws DBException;
    public List<String> nameDepartments() throws DBException;

}
