import javax.ws.rs.*;

// The Java class will be hosted at the URI path "/helloworld"
@Path("/")
public class HelloWorld {
    // The Java method will process HTTP GET requests
    @GET
    @Path("/hello")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("text/plain")
    public String getClichedMessage() {
        // Return some cliched textual content
        return "Hello World";
    }

    @GET
    @Path("/hello/api")
    @Produces("text/plain")
    public String getSimpleResponse() {
        return "Getting...";
    }

    @PUT
    @Path("/hello/api/{id}")
    @Consumes("text/plain")
    @Produces("text/plain")
    public String putSimpleResponse(@PathParam("id") int id) {
        return "Putting: " + id;
    }

    @POST
    @Path("/hello/api/{str}")
    @Produces("text/plain")
    public String postSimpleResponse(@PathParam("str") String str) {
        return "Posting: " + str;
    }

    @DELETE
    @Path("/{id}")
    @Consumes("text/plain")
    @Produces("text/plain")
    public String deleteSimple(@PathParam("id") int id) {
        return "Deleting: " + id;
    }
}