/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Homework 13
 */

import oracle.kv.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

public class LoadDB {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        load(store);
        store.close();
    }

    public static void load(KVStore store) throws SQLException{
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");

        loadActors(store, jdbcConnection);
        loadMovies(store, jdbcConnection);
        loadRoles(store, jdbcConnection);
        jdbcConnection.close();
    }

    public static void loadMovies(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, year, rank FROM Movie");
        while (resultSet.next()) {
            Key keyName = Key.createKey(Arrays.asList("movie"), Arrays.asList(resultSet.getString(1), "name"));
            Value valueName = Value.createValue(resultSet.getString(2).getBytes());
            store.put(keyName, valueName);
            Key keyYear = Key.createKey(Arrays.asList("movie"), Arrays.asList(resultSet.getString(1), "year"));
            Value valueYear = Value.createValue(resultSet.getString(3).getBytes());
            store.put(keyYear, valueYear);
            Key keyRank = Key.createKey(Arrays.asList("movie"), Arrays.asList( resultSet.getString(1), "rank"));
            String rank = resultSet.getString(4);
            Value valueRank = Value.createValue("".getBytes());
            if (rank != null) {
                valueRank = Value.createValue(resultSet.getString(4).getBytes());
            }
            store.put(keyRank, valueRank);
        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void loadActors(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, firstname, lastname FROM Actor");
        while (resultSet.next()) {
            Key keyFirstname = Key.createKey(Arrays.asList("actor", resultSet.getString(1)), Arrays.asList("firstname"));
            Value valueFirstname = Value.createValue(resultSet.getString(2).getBytes());
            store.put(keyFirstname, valueFirstname);
            Key keyLastname = Key.createKey(Arrays.asList("actor", resultSet.getString(1)), Arrays.asList("lastname"));
            Value valueLastname = Value.createValue(resultSet.getString(3).getBytes());
            store.put(keyLastname, valueLastname);

        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void loadRoles(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT actorid, movieid, role FROM Role");

        // Build arraylists of the things we want to add to the KVStore
        ArrayList<Key> actorKeys = new ArrayList<Key>();
        ArrayList<ArrayList<String>> actorValues = new ArrayList<>();
        ArrayList<Key> movieKeys = new ArrayList<Key>();
        ArrayList<ArrayList<String>> movieValues = new ArrayList<>();
        while (resultSet.next()) {
            Key keyActor = Key.createKey(Arrays.asList("movie", resultSet.getString(2)), Arrays.asList("actors", resultSet.getString(1)));

            // If I have not seen this actor yet
            if (!actorKeys.contains(keyActor)) {
                actorKeys.add(keyActor);
                actorValues.add(new ArrayList<>());
            }

            // Add the role to the list of actors for this movie
            actorValues.get(actorKeys.indexOf(keyActor)).add(resultSet.getString(3) + ":");

            Key keyMovie = Key.createKey(Arrays.asList("actor", resultSet.getString(1)), Arrays.asList("movies", resultSet.getString(2)));

            // If I have not seen this movie yet
            if (!movieKeys.contains(keyMovie)) {
                movieKeys.add(keyMovie);
                movieValues.add(new ArrayList<>());
            }

            // Add the role to the list of movies for this actor
            movieValues.get(movieKeys.indexOf(keyMovie)).add(resultSet.getString(3) + ":");
        }

        // Insert the things from the arraylists into the KVStore'
        for (int i = 0; i < actorKeys.size(); i++) {
            String value = actorValues.get(i).toString();
            store.put(actorKeys.get(i), Value.createValue(value.substring(1, value.length()-2).getBytes()));
        }
        for (int i = 0; i < movieKeys.size(); i++) {
            String value = movieValues.get(i).toString();
            store.put(movieKeys.get(i), Value.createValue(value.substring(1, value.length()-2).getBytes()));
        }

        resultSet.close();
        jdbcStatement.close();
    }
}