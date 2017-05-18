package models;

import javax.persistence.*;
import java.util.List;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Project
 * Main class for the Room table
 */
@Entity
@Table(name = "ROOM", schema = "ZACHPROJECT", catalog = "")
public class Room {
    @Id
    private long id;
    private String name;
    private Long capacity;
    private Long ticketsremaining;
//    private List<Room> employeeRoom;
//    private List<Room> bandRoom;

    // Joining the Room and Venue table
    @ManyToOne
    @JoinColumn(name = "VENUEID", referencedColumnName = "ID")

    private Venue venue;

    // Joining the BandBooking, Band, and Room tables
    @ManyToMany
    @JoinTable(name = "BANDBOOKING", schema = "ZACHPROJECT",
            joinColumns = @JoinColumn(name = "BANDID", referencedColumnName = "ID", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "ROOMID", referencedColumnName = "ID", nullable = false))

    private List<Band> bands;



    @Transient
//    private long venueId;

    public Venue getVenue() {
        return venue;
    }

    public void setVenue(Venue venue) {
        this.venue = venue;
    }

//    public long getVenueId() {
//        return venueId;
//    }
//
//    public void setVenueId(long venueId) {
//        this.venueId = venueId;
//    }

    public List<Band> getBands() {
        return bands;
    }

    public void setBands(List<Band> bands) {
        this.bands = bands;
    }

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
    @Column(name = "CAPACITY")
    public Long getCapacity() {
        return capacity;
    }

    public void setCapacity(Long capacity) {
        this.capacity = capacity;
    }

    @Basic
    @Column(name = "TICKETSREMAINING")
    public Long getTicketsremaining() {
        return ticketsremaining;
    }

    public void setTicketsremaining(Long ticketsremaining) {
        this.ticketsremaining = ticketsremaining;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Room room = (Room) o;

        if (id != room.id) return false;
        if (name != null ? !name.equals(room.name) : room.name != null) return false;
        if (capacity != null ? !capacity.equals(room.capacity) : room.capacity != null) return false;
        if (ticketsremaining != null ? !ticketsremaining.equals(room.ticketsremaining) : room.ticketsremaining != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (capacity != null ? capacity.hashCode() : 0);
        result = 31 * result + (ticketsremaining != null ? ticketsremaining.hashCode() : 0);
        return result;
    }
}
