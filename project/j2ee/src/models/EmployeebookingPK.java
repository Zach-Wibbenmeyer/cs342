package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by zdw3 on 5/15/2017.
 */
public class EmployeebookingPK implements Serializable {
    private long employeeid;
    private long roomid;

    @Column(name = "EMPLOYEEID")
    @Id
    public long getEmployeeid() {
        return employeeid;
    }

    public void setEmployeeid(long employeeid) {
        this.employeeid = employeeid;
    }

    @Column(name = "ROOMID")
    @Id
    public long getRoomid() {
        return roomid;
    }

    public void setRoomid(long roomid) {
        this.roomid = roomid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        EmployeebookingPK that = (EmployeebookingPK) o;

        if (employeeid != that.employeeid) return false;
        if (roomid != that.roomid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (employeeid ^ (employeeid >>> 32));
        result = 31 * result + (int) (roomid ^ (roomid >>> 32));
        return result;
    }
}
