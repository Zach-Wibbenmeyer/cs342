import oracle.kv.*;

import javax.xml.crypto.dsig.keyinfo.KeyValue;
import java.sql.SQLException;
import java.util.*;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Project 5
 * GetSortedInceptionofBands - Main class for retrieving a list of bands sorted by their inception date
 */
public class GetSortedInceptionOfBands {

    public static void main(String[] args) throws SQLException {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadProjectDB.load(store);

        sortInceptionOfBands(store);

        store.close();
    }

    /**
     * sortInceptionOfBands() - Sorts bands by the year they started playing together
     * @param store
     * @return: Nothing
     */
    public static void sortInceptionOfBands(KVStore store) {
        HashMap<String, List<List<String>>> bands = new HashMap<>();
        SortedSet<Integer> integers = new TreeSet<>();

        Key key = Key.createKey(Arrays.asList("Band"));
        Iterator<KeyValueVersion> it = store.storeIterator(Direction.UNORDERED, 0, key, null, null);

        while (it.hasNext()) {
            List<String> currentBand = new ArrayList<>();
            KeyValueVersion kvv = it.next();

            if (kvv.getKey().getMinorPath().get(0).equals("inception")) {
                String bandId = kvv.getKey().getMajorPath().get(1);
                String inception = new String(kvv.getValue().getValue());
                currentBand.add(bandId);
                currentBand.add(getNameOfBand(bandId, store));

                if (!integers.contains(Integer.parseInt(inception))) {
                    integers.add(Integer.parseInt(inception));
                }

                if (bands.containsKey(inception)) {
                    bands.get(inception).add(currentBand);
                } else {
                    List<List<String>> more = new ArrayList<>();
                    more.add(currentBand);
                    bands.put(inception, more);
                }
            }
        }

        for (Integer inception : integers) {
            for (List<String> bandInformation : bands.get(inception.toString())) {
                System.out.println(inception + "\t");
                for (String information : bandInformation) {
                    System.out.println(information + "\t");
                }
                System.out.println("\n");
            }
        }
    }

    /**
     * getNameOfBand() - gets the name of the band
     * @param bandId
     * @param store
     * @return a String
     */
    private static String getNameOfBand(String bandId, KVStore store) {
        String temp = "";
        Key majorKeyPath = Key.createKey(Arrays.asList("Band", bandId));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPath, null, null);

        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            if (field.getKey().getMinorPath().get(0).equals("name")) {
                temp = new String(field.getValue().getValue().getValue());
            }
        }

        return temp;
    }
}
