/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Project
 */

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

@ApplicationPath("/")
public class MyApplication extends Application{
    @Override
    public Set<Class<?>> getClasses() {
        HashSet h = new HashSet<Class<?>>();
        h.add( ZachProjectResource.class );
        return h;
    }
}