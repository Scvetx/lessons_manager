/* Helpful dart code to work with Firebase Firestore collections (database custom objects)
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollection {
// --- VARIABLES ---
  final String fTeacherId = 'teacherId'; // current teacher user id

  final String collectionName;

// --- CONSTRUCTOR ---
  FirebaseCollection({required this.collectionName});

// --- METHODS ---
// - DML -
  Future createRecord(Map<String, dynamic> fieldsMap) async {
    FirebaseFirestore fb = FirebaseFirestore.instance;
    await fb.collection(collectionName).add(fieldsMap);
  }

  Future editRecord(String id, Map<String, dynamic> data) async {
    FirebaseFirestore fb = FirebaseFirestore.instance;
    await fb.collection(collectionName).doc(id).update(data);
  }

  Future deleteRecord(String id) async {
    FirebaseFirestore fb = FirebaseFirestore.instance;
    await fb.collection(collectionName).doc(id).delete();
  }

// - QUERY RECORDS -
  Future<List<QueryDocumentSnapshot<Object?>>> queryRecords(
      Map<String, String> whereMap) async {
    CollectionReference<Map<String, dynamic>> collectionRef =
        FirebaseFirestore.instance.collection(collectionName);
    dynamic query = collectionRef;
    for (var entry in whereMap.entries) {
      query = query.where(entry.key, isEqualTo: entry.value);
    }
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs;
  }
}
