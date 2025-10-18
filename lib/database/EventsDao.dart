import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/database/model/Event.dart';

class EventsDao {
  static var _db = FirebaseFirestore.instance;

  static CollectionReference<Event> _getEventsCollection() {
    return _db
        .collection('events')
        .withConverter<Event>(
          fromFirestore: (snapshot, options) => Event.fromMap(snapshot.data()),
          // convert from firestore map to my object
          toFirestore: (event, options) => event.toMap(),
        ); //convert from my obj to the firestore map
  }

  static Future<void> addEvent(Event event) async {
    //insert into db
    var doc = _getEventsCollection().doc();
    event.id = doc.id;

    await doc.set(event);
  }

  static Future<List<Event>> getEvents() async {
    var collectionRef = await _getEventsCollection().get();

    return collectionRef.docs.map((snapshot) => snapshot.data()).toList();
  }
}
