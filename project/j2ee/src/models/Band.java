package models;

import javax.persistence.*;
import java.util.List;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Project
 * Main class for the Band table
 */
@Entity
@Table(name = "BAND", schema = "ZACHPROJECT", catalog = "")
public class Band {
    @Id
    private long id;
    private String name;
    private String hometowncity;
    private String hometownstate;
    private String genre;
    private Long members;
    private Long inception;
    private Long albums;

//    @ManyToMany
//    @JoinTable(name = "BANDBOOKING", schema = "ZACHPROJECT",
//            joinColumns = @JoinColumn(name = "BANDID", referencedColumnName = "ID", nullable = false),
//            inverseJoinColumns = @JoinColumn(name = "ROOMID", referencedColumnName = "ID", nullable = false))
//
//    private List<Room> playingInRoom;
//
//    private List<Room> getPlayingInRoom() {
//        return playingInRoom;
//    }
//
//    private void setPlayingInRoom(List<Room> playingInRoom) {
//        this.playingInRoom = playingInRoom;
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
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "HOMETOWNCITY")
    public String getHometowncity() {
        return hometowncity;
    }

    public void setHometowncity(String hometowncity) {
        this.hometowncity = hometowncity;
    }

    @Basic
    @Column(name = "HOMETOWNSTATE")
    public String getHometownstate() {
        return hometownstate;
    }

    public void setHometownstate(String hometownstate) {
        this.hometownstate = hometownstate;
    }

    @Basic
    @Column(name = "GENRE")
    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    @Basic
    @Column(name = "MEMBERS")
    public Long getMembers() {
        return members;
    }

    public void setMembers(Long members) {
        this.members = members;
    }

    @Basic
    @Column(name = "INCEPTION")
    public Long getInception() {
        return inception;
    }

    public void setInception(Long inception) {
        this.inception = inception;
    }

    @Basic
    @Column(name = "ALBUMS")
    public Long getAlbums() {
        return albums;
    }

    public void setAlbums(Long albums) {
        this.albums = albums;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Band band = (Band) o;

        if (id != band.id) return false;
        if (name != null ? !name.equals(band.name) : band.name != null) return false;
        if (hometowncity != null ? !hometowncity.equals(band.hometowncity) : band.hometowncity != null) return false;
        if (hometownstate != null ? !hometownstate.equals(band.hometownstate) : band.hometownstate != null)
            return false;
        if (genre != null ? !genre.equals(band.genre) : band.genre != null) return false;
        if (members != null ? !members.equals(band.members) : band.members != null) return false;
        if (inception != null ? !inception.equals(band.inception) : band.inception != null) return false;
        if (albums != null ? !albums.equals(band.albums) : band.albums != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (hometowncity != null ? hometowncity.hashCode() : 0);
        result = 31 * result + (hometownstate != null ? hometownstate.hashCode() : 0);
        result = 31 * result + (genre != null ? genre.hashCode() : 0);
        result = 31 * result + (members != null ? members.hashCode() : 0);
        result = 31 * result + (inception != null ? inception.hashCode() : 0);
        result = 31 * result + (albums != null ? albums.hashCode() : 0);
        return result;
    }
}
