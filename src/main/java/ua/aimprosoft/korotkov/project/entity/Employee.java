package ua.aimprosoft.korotkov.project.entity;

import java.util.Date;

/**
 * Created by Андрей on 30.01.2017.
 */
public class Employee extends Entity{

    private static final long serialVersionUID = 5352087651905517102L;

    private String firstName;
    private String lastName;
    private Date birthday;
    private String phone;
    private String email;
    private int idDepartment;

    public Employee() {
    }
    public Employee(String firstName, String lastName, Date d, String phone, String email, int idDepartment) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.birthday = d;
        this.phone = phone;
        this.email = email;
        this.idDepartment = idDepartment;
    }

    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public Date getBirthday() {
        return birthday;
    }
    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public int getIdDepartment() {
        return idDepartment;
    }
    public void setIdDepartment(int idDepartment) {
        this.idDepartment = idDepartment;
    }

    @Override
    public String toString() {
        return "Employee: " +
                "firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", birthday=" + birthday +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", idDepartment=" + idDepartment;
    }
}
