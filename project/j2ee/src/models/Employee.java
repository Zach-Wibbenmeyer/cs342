package models;

import javax.persistence.*;
import java.sql.Time;
import java.util.List;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Project
 * Main class for the Employee table
 */
@Entity
@Table(name = "EMPLOYEE", schema = "ZACHPROJECT")
public class Employee {
    @Id
    private long id;
    private String firstname;
    private String lastname;
    private Time hiredate;
    private String streetname;
    private String city;
    private String state;
    private String zipcode;
//    private List<Room> booking;
//
//    @ManyToMany
//    @JoinTable(name = "EMPLOYEEBOOKING", schema = "ZACHPROJECT",
//            joinColumns = @JoinColumn(name = "EMPLOYEEID", referencedColumnName = "ID", nullable = false),
//            inverseJoinColumns = @JoinColumn(name = "ROOMID", referencedColumnName = "ID", nullable = false))
//
//    public List<Room> getBooking() {
//        return booking;
//    }
//
//    public void setBooking(List<Room> booking) {
//        this.booking = booking;
//    }

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "FIRSTNAME")
    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    @Basic
    @Column(name = "LASTNAME")
    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    @Basic
    @Column(name = "HIREDATE")
    public Time getHiredate() {
        return hiredate;
    }

    public void setHiredate(Time hiredate) {
        this.hiredate = hiredate;
    }

    @Basic
    @Column(name = "STREETNAME")
    public String getStreetname() {
        return streetname;
    }

    public void setStreetname(String streetname) {
        this.streetname = streetname;
    }

    @Basic
    @Column(name = "CITY")
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Basic
    @Column(name = "STATE")
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Basic
    @Column(name = "ZIPCODE")
    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Employee employee = (Employee) o;

        if (id != employee.id) return false;
        if (firstname != null ? !firstname.equals(employee.firstname) : employee.firstname != null) return false;
        if (lastname != null ? !lastname.equals(employee.lastname) : employee.lastname != null) return false;
        if (hiredate != null ? !hiredate.equals(employee.hiredate) : employee.hiredate != null) return false;
        if (streetname != null ? !streetname.equals(employee.streetname) : employee.streetname != null) return false;
        if (city != null ? !city.equals(employee.city) : employee.city != null) return false;
        if (state != null ? !state.equals(employee.state) : employee.state != null) return false;
        if (zipcode != null ? !zipcode.equals(employee.zipcode) : employee.zipcode != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (firstname != null ? firstname.hashCode() : 0);
        result = 31 * result + (lastname != null ? lastname.hashCode() : 0);
        result = 31 * result + (hiredate != null ? hiredate.hashCode() : 0);
        result = 31 * result + (streetname != null ? streetname.hashCode() : 0);
        result = 31 * result + (city != null ? city.hashCode() : 0);
        result = 31 * result + (state != null ? state.hashCode() : 0);
        result = 31 * result + (zipcode != null ? zipcode.hashCode() : 0);
        return result;
    }
}
