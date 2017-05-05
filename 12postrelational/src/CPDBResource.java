import models.HouseholdEntity;
import models.PersonEntity;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("cpdb")
public class CPDBResource {

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
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public PersonEntity getPerson(@PathParam("id") long id) {
        return em.find(PersonEntity.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PersonEntity> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(PersonEntity.class)).getResultList();
    }

    /**
     * deletePerson() - deletes a person from the database
     *
     * @param id The id of the person to delete
     * @return String
     */
    @DELETE
    @Path("person/{id}")
    public String deletePerson(@PathParam("id") long id) {
        PersonEntity person = em.find(PersonEntity.class, id);

        if (person != null) {
            em.remove(person);
            return "You just removed a person";
        }
        return "I could not find that specified person";
    }


    /**
     * updatePerson() - updates a person in the database
     *
     *
     * @param id - id of the person to update
     * @param information - JSON representing PersonEntity
     * @return PersonEntity
     */
    @PUT
    @Path("person/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public PersonEntity updatePerson(@PathParam("id") long id, PersonEntity information) {
        information.setId(id);
        PersonEntity person = em.find(PersonEntity.class, id);

        if (person != null) {
            information.setHousehold(em.find(HouseholdEntity.class, information.getHousehold()));
            return em.merge(information);
        }

        return null;
    }

    /**
     * addPerson() - add a person to the database
     *
     * @param person - PersonEntity class
     * @return a String
     */
    @POST
    @Path("people")
    public String addPerson(PersonEntity person) {
        try {
            person.setHousehold(em.find(HouseholdEntity.class, person.getHouseholdId()));
            em.persist(person);
        } catch (Exception e) {
            return "Something went wrong..." + e.getMessage();
        }
        return "Person was successfully added";
    }

}