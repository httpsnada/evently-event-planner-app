import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/database/model/AppUser.dart';

class UsersDao {
  static var _db = FirebaseFirestore.instance;

  static CollectionReference<AppUser> _getUsersCollection() {
    return _db
        .collection('users')
        .withConverter<AppUser>(
          fromFirestore: (snapshot, options) =>
              AppUser.fromMap(snapshot.data()),
          // convert from firestore map to my object
          toFirestore: (user, options) => user.toMap(),
        ); //convert from my obj to the firestore map
  }

  static Future<void> addUser(AppUser user) async {
    //insert into db
    var docRef =
        _getUsersCollection() //return users collection [table]
            //.doc();                           // auto generate id
            .doc(user.id); // new doc labeled as the user's id

    await docRef.set(user);
  }

  static Future<AppUser?> getUserById(String? id) async {
    // var doc = await _db.collection('users').doc(id) //doc id
    //     .get();
    // AppUser user = AppUser.fromMap(doc.data());
    var doc = await _getUsersCollection().doc(id).get();
    return doc.data();
  }
}

// we connect the user id in the id table with the uid in the authentication table
