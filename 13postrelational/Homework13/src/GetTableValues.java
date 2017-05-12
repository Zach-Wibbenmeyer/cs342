import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Homework 13
 */
public class GetTableValues {

    public static void main(String[] args) throws SQLException{
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.load(store);

        execute(store);
        store.close();
    }

    public static void execute(KVStore store) {
        System.out.println("Table: movie\nID: 92616");
        Key majorKey = Key.createKey(Arrays.asList("movie", "92616"));
        Map<Key, ValueVersion> fields = store.multiGet(majorKey, null, null);
        String[] info = new String[3];
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            if (field.getKey().getMinorPath().get(0).equals("name")) {
                info[0] = new String(field.getValue().getValue().getValue());
            } else if (field.getKey().getMinorPath().get(0).equals("year")) {
                info[1] = new String(field.getValue().getValue().getValue());
            } else {
                info[2] = new String(field.getValue().getValue().getValue());
            }
        }
        System.out.println("\t" + info[0] + "\n\t" + info[1] + "\n\t" + info[2]);
    }
}