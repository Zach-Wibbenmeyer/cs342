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
 */
@Stateless
@Path("/")
public class ZachProjectResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
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
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("band/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Band getBand(@PathParam("id") long id) {
        return em.find(Band.class, id);
    }

    /**
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("room/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Room getRoom(@PathParam("id") long id) {
        return em.find(Room.class, id);
    }


    /**
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("employee/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Employee getEmployee(@PathParam("id") long id) {
        return em.find(Employee.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("bands")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Band> getBands() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Band.class)).getResultList();
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("employees")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Employee> getEmployees() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Employee.class)).getResultList();
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("rooms")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Room> getRooms() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Room.class)).getResultList();
    }

    /**
     * Delete an individual room record
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