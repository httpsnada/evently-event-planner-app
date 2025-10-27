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

  static Future<List<Event>> getEvents(int? categoryID) async {
    var query = await _getEventsCollection();
    if (categoryID != null && categoryID != 0) {
      query.where("categoryID", isEqualTo: categoryID);
    }
    query.orderBy('date', descending: false)
        .orderBy('time', descending: false);

    var collectionRef = await query.get();

    return collectionRef.docs.map((snapshot) => snapshot.data()).toList();
  }

  static Future<List<Event>> getFavorites(int? categoryID
      , List<String> eventIds) async {
    var collectionReference = await _getEventsCollection();

    var query = collectionReference
        .orderBy('date', descending: false)
        .orderBy('time', descending: false);

    if (eventIds.isNotEmpty == true) {
      query = query.where(FieldPath.documentId, whereIn: eventIds);
    }

    query = query.where("categoryID", isEqualTo: categoryID);

    var collectionRef = await query.get();

    return collectionRef.docs.map((snapshot) => snapshot.data()).toList();
  }


  static Stream<List<Event>> getRealTimeEvents(int? categoryID) async* {
    var collectionReference = _getEventsCollection();

    var query = collectionReference
        .orderBy('date', descending: false)
        .orderBy('time', descending: false);

    if (categoryID != null && categoryID != 0) {
      query = query.where("categoryID", isEqualTo: categoryID);
    }

    var collectionRef = query.snapshots();

    yield* collectionRef.map((event) =>
        event.docs.map((snapshot) => snapshot.data()).toList());
  }


  Future<void> deleteEvent(String id) async {
    await _db.collection('events').doc(id).delete();
    final users = await _db.collection('users').get();
    for (final user in users.docs) {
      final favs = List<String>.from(user['favorites'] ?? []);
      if (favs.contains(id)) {
        await user.reference.update({
          'favorites': FieldValue.arrayRemove([id]),
        });
      }
    }
  }


  static Future<void> updateEvent(Event event) async {
    try {
      await _getEventsCollection().doc(event.id).update(event.toMap());
    } catch (e) {
      print("Error updating event: $e");
    }
  }

}
