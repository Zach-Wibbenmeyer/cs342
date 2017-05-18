import oracle.kv.KVStore;
import oracle.kv.Key;
import oracle.kv.ValueVersion;

import java.util.Arrays;
import java.util.Map;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Project 5
 * Formulate - Main class for making key value pairs easy
 */

/**
 * This is used for help in checking for valid key pairs
 */
public class Formulate {

    public static void printKVObject(KVStore store, String objectId, String majorKeyLabel) {
        Key majorKeyPath = Key.createKey(Arrays.asList(majorKeyLabel, objectId));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPath, null, null);
        if(fields.isEmpty()) {
            System.out.println("This record does not exist");
            System.out.println("Table: " + majorKeyLabel + " ID: " + objectId);
            System.exit(1);
        }
        System.out.println(majorKeyLabel + " record:");
        System.out.println("ID: " + objectId);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }
    }
}
