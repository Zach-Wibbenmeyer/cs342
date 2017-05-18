import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/**
 * Zach Wibbenmeyer
 * Professor Vanderlinden
 * CS342 - Project 5
 * GetVenueRooms - Main class for creating a two table join between the tables Venue and Room
 */

public class GetVenueRooms {

    // Main program
    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadProjectDB.load(store);

        execute(store);

        store.close();

    }

    /**
     * execute() - Useful two table join. Displays what rooms are in which venues
     * @param store
     * @return: Nothing
     */
    public static void execute(KVStore store) {
        Scanner scan = new Scanner(System.in);

        System.out.println("Enter a Room ID: ");
        String roomId = Integer.toString(scan.nextInt());

        Formulate.printKVObject(store, roomId, "Room");

        Key roomIdKeyPath = Key.createKey(Arrays.asList("Room", roomId), Arrays.asList("venueID"));
        String venueId = new String(store.get(roomIdKeyPath).getValue().getValue());

        if (!venueId.isEmpty()) {
            Formulate.printKVObject(store, venueId, "Venue");
        }
    }
}