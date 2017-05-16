package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by zdw3 on 5/15/2017.
 */
public class BandbookingPK implements Serializable {
    private long bandid;
    private long roomid;

    @Column(name = "BANDID")
    @Id
    public long getBandid() {
        return bandid;
    }

    public void setBandid(long bandid) {
        this.bandid = bandid;
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

        BandbookingPK that = (BandbookingPK) o;

        if (bandid != that.bandid) return false;
        if (roomid != that.roomid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (bandid ^ (bandid >>> 32));
        result = 31 * result + (int) (roomid ^ (roomid >>> 32));
        return result;
    }
}
