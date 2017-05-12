import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Homework 13
 */
public class GetMovieActorRoles {

    public static void main(String[] args) throws SQLException{
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.load(store);

        execute(store);
        store.close();
    }

    public static void execute(KVStore store) {
        System.out.println("Movie: 92616\nActor: 429719");
        Key key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("actors", "429719"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String roles = new String(field.getValue().getValue().getValue());
            String[] roleArray = roles.split(":, ");
            for (String role : roleArray) {
                System.out.println("\t" + role);
            }
        }
    }
}