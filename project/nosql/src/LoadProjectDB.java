import oracle.kv.*;

import java.sql.*;
import java.text.Normalizer;
import java.util.*;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Project 5
 * LoadProjectDB - Main class for loading all of the tables
 */

/**
 * Key Value Structure
 *
 * Venue table:
 *
 * /venue/{ID}/-/name/{name}
 * /venue/{ID}/-/streetName/{streetName}
 * /venue/{ID}/-/city/{city}
 * /venue/{ID}/-/state/{state}
 * /venue/{ID}/-/zipcode/{zipcode}
 *
 *
 *
 * Room table:
 *
 * /room/{ID}/-/name/{name}
 * /room/{ID}/-/capacity/{capacity}
 * /room/{ID}/-/ticketsRemaining/{capacity}
 * /room/{ID}/-/venueID/{venueID}
 *
 *
 *
 * Band table:
 *
 * /band/{ID}-/name/{name}
 * /band/{ID}-/hometownCity/{hometownCity}
 * /band/{ID}-/hometownState/{hometownState}
 * /band/{ID}-/genre/{genre}
 * /band/{ID}-/members/{members}
 * /band/{ID}-/inception/{inception}
 * /band/{ID}-/albums/{albums}
 */

public class LoadProjectDB {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        load(store);
        store.close();
    }

    /**
     * Main call for loading all of the tables
     * @param store
     * @throws SQLException
     */
    public static void load(KVStore store) throws SQLException {
        Connection zachprojectConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@//localhost:1521/XE", "zachproject", "fakedoorsdotcom35");

        System.out.println("Loading the data");
        loadVenues(store, zachprojectConnection);
        loadRooms(store, zachprojectConnection);
        loadBands(store, zachprojectConnection);
        zachprojectConnection.close();
    }

    /**
     * Load all the venues from the database
     * @param store
     * @param zachprojectConnection
     * @throws SQLException
     */
    public static void loadVenues(KVStore store, Connection zachprojectConnection) throws SQLException {
        Statement zachprojectStatement = zachprojectConnection.createStatement();
        ResultSet resultSet = zachprojectStatement.executeQuery("SELECT ID, name, streetName, city, state, zipcode FROM Venue");
        while (resultSet.next()) {

            String venueId = resultSet.getString(1);
            String venueName = resultSet.getString(2);
            String venueStreetName = resultSet.getString(3);
            String venueCity = resultSet.getString(4);
            String venueState = resultSet.getString(5);
            String venueZipcode = resultSet.getString(6);

            Key venueNameKey = Key.createKey(Arrays.asList("Venue", venueId), Arrays.asList("name"));
            Key venueStreetNameKey = Key.createKey(Arrays.asList("Venue", venueId), Arrays.asList("streetName"));
            Key venueCityKey = Key.createKey(Arrays.asList("Venue", venueId), Arrays.asList("city"));
            Key venueStateKey = Key.createKey(Arrays.asList("Venue", venueId), Arrays.asList("state"));
            Key venueZipcodeKey = Key.createKey(Arrays.asList("Venue", venueId), Arrays.asList("zipcode"));

            Value venueNameValue = Value.createValue(venueName.getBytes());
            Value venueStreetNameValue = Value.createValue(venueStreetName.getBytes());
            Value venueCityValue = Value.createValue(venueCity.getBytes());
            Value venueStateValue = Value.createValue(venueState.getBytes());
            Value venueZipcodeValue = Value.createValue(venueZipcode.getBytes());

            store.put(venueNameKey, venueNameValue);
            store.put(venueStreetNameKey, venueStreetNameValue);
            store.put(venueCityKey, venueCityValue);
            store.put(venueStateKey, venueStateValue);
            store.put(venueZipcodeKey, venueZipcodeValue);

            Formulate.printKVObject(store, venueId, "Venue");
        }

        resultSet.close();
    }

    /**
     * Load all the rooms from the database
     * @param store
     * @param zachprojectConnection
     * @throws SQLException
     */
    public static void loadRooms(KVStore store, Connection zachprojectConnection) throws SQLException {
        Statement zachprojectStatement = zachprojectConnection.createStatement();
        ResultSet resultSet = zachprojectStatement.executeQuery("SELECT ID, name, capacity, ticketsRemaining, venueID FROM Room");
        
        while (resultSet.next()) {

            String roomId = resultSet.getString(1);
            String roomName = resultSet.getString(2);
            String roomCapacity = resultSet.getString(3);
            String roomTicketsRemaining = resultSet.getString(4);
            String roomVenueId = resultSet.getString(5);

            Key roomNameKey = Key.createKey(Arrays.asList("Room", roomId), Arrays.asList("name"));
            Key roomCapacityKey = Key.createKey(Arrays.asList("Room", roomId), Arrays.asList("capacity"));
            Key roomTicketsRemainingKey = Key.createKey(Arrays.asList("Room", roomId), Arrays.asList("ticketsRemaining"));
            Key roomVenueIdKey = Key.createKey(Arrays.asList("Room", roomId), Arrays.asList("venueID"));

            Value roomNameValue = Value.createValue(roomName.getBytes());
            Value roomCapacityValue = Value.createValue(roomCapacity.getBytes());
            Value roomTicketsRemainingValue = Value.createValue(roomTicketsRemaining.getBytes());
            Value roomVenueIdValue = Value.createValue(roomVenueId.getBytes());

            store.put(roomNameKey, roomNameValue);
            store.put(roomCapacityKey, roomCapacityValue);
            store.put(roomTicketsRemainingKey, roomTicketsRemainingValue);
            store.put(roomVenueIdKey, roomVenueIdValue);

            Formulate.printKVObject(store, roomId, "Room");
        }

        resultSet.close();

    }

    /**
     * load all of the bands from the database
     * @param store
     * @param zachprojectConnection
     * @throws SQLException
     */
    public static void loadBands(KVStore store, Connection zachprojectConnection) throws SQLException {
        Statement zachprojectStatement = zachprojectConnection.createStatement();
        ResultSet resultSet = zachprojectStatement.executeQuery("SELECT ID, name, hometownCity, hometownState, genre, members, inception, albums FROM Band");
        while (resultSet.next()) {

            String bandId = resultSet.getString(1);
            String bandName = resultSet.getString(2);
            String bandHometownCity = resultSet.getString(3);
            String bandHometownState = resultSet.getString(4);
            String bandGenre = resultSet.getString(5);
            String bandMembers = resultSet.getString(6);
            String bandInception = resultSet.getString(7);
            String bandAlbums = resultSet.getString(8);

            Key bandNameKey = Key.createKey(Arrays.asList("Band", bandId), Arrays.asList("name"));
            Key bandHometownCityKey = Key.createKey(Arrays.asList("Band", bandId), Arrays.asList("hometownCity"));
            Key bandHometownStateKey = Key.createKey(Arrays.asList("Band", bandId), Arrays.asList("hometownState"));
            Key bandGenreKey = Key.createKey(Arrays.asList("Band", bandId), Arrays.asList("genre"));
            Key bandMembersKey = Key.createKey(Arrays.asList("Band", bandId), Arrays.asList("members"));
            Key bandInceptionKey = Key.createKey(Arrays.asList("Band", bandId), Arrays.asList("inception"));
            Key bandAlbumsKey = Key.createKey(Arrays.asList("Band", bandId), Arrays.asList("albums"));

            Value bandNameValue = Value.createValue(bandName.getBytes());
            Value bandHometownCityValue = Value.createValue(bandHometownCity.getBytes());
            Value bandHometownStateValue = Value.createValue(bandHometownState.getBytes());
            Value bandGenreValue = Value.createValue(bandGenre.getBytes());
            Value bandMembersValue = Value.createValue(bandMembers.getBytes());
            Value bandInceptionValue = Value.createValue(bandInception.getBytes());
            Value bandAlbumsValue = Value.createValue(bandAlbums.getBytes());

            store.put(bandNameKey, bandNameValue);
            store.put(bandHometownCityKey, bandHometownCityValue);
            store.put(bandHometownStateKey, bandHometownStateValue);
            store.put(bandGenreKey, bandGenreValue);
            store.put(bandMembersKey, bandMembersValue);
            store.put(bandInceptionKey, bandInceptionValue);
            store.put(bandAlbumsKey, bandAlbumsValue);

            Formulate.printKVObject(store, bandId, "Band");
        }

        resultSet.close();
    }
}