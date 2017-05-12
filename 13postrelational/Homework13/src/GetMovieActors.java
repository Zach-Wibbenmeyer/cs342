import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Homework 13
 */
public class GetMovieActors {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.load(store);
        execute(store);
        store.close();
    }

    public static void execute(KVStore store) {
        System.out.println("Movie: 92616");
        Key key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("actors"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String actorid = field.getKey().getMinorPath().get(1);
            Map<Key, ValueVersion> actor = store.multiGet(Key.createKey(Arrays.asList("actor", actorid)), null, null);
            String firstName = "";
            String lastName = "";
            for (Map.Entry<Key, ValueVersion> afield : actor.entrySet()) {
                //System.out.println(afield.getKey().getMinorPath());
                if (afield.getKey().getMinorPath().get(0).equals("firstName")) {
                    firstName = new String(afield.getValue().getValue().getValue());
                } else if (afield.getKey().getMinorPath().get(0).equals("lastName")) {
                    lastName = new String(afield.getValue().getValue().getValue());
                }
            }

            String[] roles = new String(field.getValue().getValue().getValue()).split(":, ");
            for (String role : roles) {
                System.out.println(actorid + "\t" + firstName + " " + lastName + "\t" + role);
            }
        }
    }
}