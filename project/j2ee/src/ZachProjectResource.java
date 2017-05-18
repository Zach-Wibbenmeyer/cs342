import models.Band;
import models.Employee;
import models.Room;
import models.Venue;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.print.attribute.standard.Media;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Project 5
 * ZachProjectResource - Main class that holds all of the web service requests
 */
@Stateless
@Path("/")
public class ZachProjectResource {

    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual band record.
     *
     * @param id the ID of the band to retrieve
     * @return a band record
     */
    @GET
    @Path("band/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Band getBand(@PathParam("id") long id) {
        return em.find(Band.class, id);
    }

    /**
     * GET an individual room record.
     *
     * @param id the ID of the room to retrieve
     * @return a room record
     */
    @GET
    @Path("room/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Room getRoom(@PathParam("id") long id) {
        return em.find(Room.class, id);
    }


    /**
     * GET an individual employee record.
     *
     * @param id the ID of the employee to retrieve
     * @return a employee record
     */
    @GET
    @Path("employee/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Employee getEmployee(@PathParam("id") long id) {
        return em.find(Employee.class, id);
    }

    /**
     * GET all bands using the criteria query API.
     *
     * @return a list of all band records
     */
    @GET
    @Path("bands")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Band> getBands() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Band.class)).getResultList();
    }

    /**
     * GET all employees using the criteria query API.
     *
     * @return a list of all employee records
     */
    @GET
    @Path("employees")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Employee> getEmployees() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Employee.class)).getResultList();
    }

    /**
     * GET all rooms using the criteria query API.
     *
     * @return a list of all room records
     */
    @GET
    @Path("rooms")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Room> getRooms() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Room.class)).getResultList();
    }

    /**
     * Delete an individual room record
     *
     * @return: an updated room record
     */
    @DELETE
    @Path("room/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Room deleteRoom(@PathParam("id") long id) {
        Room room = em.find(Room.class, id);

        if (room != null) {
            em.remove(room);
        }
        return room;
    }

    /**
     * PUT an indidual room record
     *
     * @return: an updated room record
     */
    @PUT
    @Path("room/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Room putRoom(Room newRoom, @PathParam("id") long id) {
        newRoom.setVenue(em.find(Venue.class, newRoom.getVenue().getId()));
        Room room = em.merge(newRoom);
        return room;
    }

    /**
     * POST an individual room record
     *
     * @return: an updated room record
     */
    @POST
    @Path("rooms")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Room postRoom(Room room) {
        Room newRoom = new Room();
        room.setId(newRoom.getId());
        room.setVenue(em.find(Venue.class, room.getVenue().getId()));
        em.persist(room);
        return room;
    }

}