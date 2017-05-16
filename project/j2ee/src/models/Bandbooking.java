package models;

import javax.persistence.*;
import java.sql.Time;

/**
 * Created by zdw3 on 5/15/2017.
 */
@Entity
@IdClass(BandbookingPK.class)
public class Bandbooking {
    private long bandid;
    private long roomid;
    private Time startdate;
    private Time enddate;

    @Id
    @Column(name = "BANDID")
    public long getBandid() {
        return bandid;
    }

    public void setBandid(long bandid) {
        this.bandid = bandid;
    }

    @Id
    @Column(name = "ROOMID")
    public long getRoomid() {
        return roomid;
    }

    public void setRoomid(long roomid) {
        this.roomid = roomid;
    }

    @Basic
    @Column(name = "STARTDATE")
    public Time getStartdate() {
        return startdate;
    }

    public void setStartdate(Time startdate) {
        this.startdate = startdate;
    }

    @Basic
    @Column(name = "ENDDATE")
    public Time getEnddate() {
        return enddate;
    }

    public void setEnddate(Time enddate) {
        this.enddate = enddate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Bandbooking that = (Bandbooking) o;

        if (bandid != that.bandid) return false;
        if (roomid != that.roomid) return false;
        if (startdate != null ? !startdate.equals(that.startdate) : that.startdate != null) return false;
        if (enddate != null ? !enddate.equals(that.enddate) : that.enddate != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (bandid ^ (bandid >>> 32));
        result = 31 * result + (int) (roomid ^ (roomid >>> 32));
        result = 31 * result + (startdate != null ? startdate.hashCode() : 0);
        result = 31 * result + (enddate != null ? enddate.hashCode() : 0);
        return result;
    }
}
