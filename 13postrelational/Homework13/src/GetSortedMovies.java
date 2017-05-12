import oracle.kv.*;

import java.sql.SQLException;
import java.util.*;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Homework 13
 */
public class GetSortedMovies {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.load(store);
        execute(store);
        store.close();
    }

    public static void execute(KVStore store) {
        Key key = Key.createKey(Arrays.asList("movie"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        HashMap<String, ArrayList<String>> movies = new HashMap<>();
        ArrayList<String> movieYears = new ArrayList<>();
        String name = "";
        String year;
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String movieId = field.getKey().getMinorPath().get(0);

            if (field.getKey().getMinorPath().get(1).equals("name")) {
                name = new String(field.getValue().getValue().getValue());
            } else if (field.getKey().getMinorPath().get(1).equals("year")) {
                year = new String(field.getValue().getValue().getValue());
                if (!movies.containsKey(year)) {
                    movies.put(year, new ArrayList<>());
                    movieYears.add(year);
                }
                movies.get(year).add(movieId + "\t" + name);
            }
        }

        Collections.sort(movieYears);
        for (String movieyear : movieYears) {
            for (String movie : movies.get(movieyear)) {
                System.out.println(movieyear + "\t" + movie);
            }
        }
    }
}