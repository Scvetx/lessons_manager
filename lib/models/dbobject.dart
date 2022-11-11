import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DBObject {
// ----- FIELDS -----
  String? id; // object id in db
  DateTime? createdDate; // record created date in db

// ----- CONSTRUCTORS -----
  DBObject.create() {
    createdDate = DateTime.now();
  }

  DBObject.fromMap(Map<String, dynamic> objMap) {
    createdDate = objMap['createdDate'].toDate();
  }

// ----- DB METHODS -----
  // convert obj to database map
  Map<String, dynamic> toMap() => {
        'createdDate': createdDate == null
            ? DateTime.now()
            : Timestamp.fromDate(createdDate!)
      };
}
