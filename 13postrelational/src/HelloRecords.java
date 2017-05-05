import java.util.Arrays;
import java.util.Map;

import oracle.kv.*;

public class HelloRecords {

    public static void main(String[] args) {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        final String movieIdString = "92616";
        String nameKeyString = "name", nameValueString = "Dr. Strangelove";
        String yearKeyString = "year", yearValueString = "1964";
        String ratingKeyString = "rating", ratingValueString = "8.7";

        Key nameKey = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(nameKeyString));
        Key yearKey = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(yearKeyString));
        Key ratingKey = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(ratingKeyString));

        Value nameValue = Value.createValue(nameValueString.getBytes());
        Value yearValue = Value.createValue(yearValueString.getBytes());
        Value ratingValue = Value.createValue(ratingValueString.getBytes());

        store.put(nameKey, nameValue);
        store.put(yearKey, yearValue);
        store.put(ratingKey, ratingValue);

        String nameKeyResult = new String(store.get(nameKey).getValue().getValue());
        System.out.println(nameKey.toString() + " : " + nameKeyResult);


        String yearKeyResult = new String(store.get(nameKey).getValue().getValue());
        System.out.println(nameKey.toString() + " : " + yearKeyResult);


        String ratingKeyResult = new String(store.get(nameKey).getValue().getValue());
        System.out.println(nameKey.toString() + " : " + ratingKeyResult);
        printLine("New movie record:");

        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", movieIdString));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }

        store.close();
    }

    private static void printLine(String output) {
        System.out.println(output);
    }

}