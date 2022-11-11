/* Helpful dart code to work with Firebase Firestore collections (database custom objects)
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workbook/models/dbobject.dart';
import 'query_filter.dart';

class FirebaseCollection {
  final String collectionName;
  late FirebaseFirestore db;
  late CollectionReference<Map<String, dynamic>> collection;

  FirebaseCollection({required this.collectionName}) {
    db = FirebaseFirestore.instance;
    collection = db.collection(collectionName);
  }

// ----- DML -----
  // create 1 record
  Future<String> createRecord(Map<String, dynamic> fieldsMap) async {
    DocumentReference<Map<String, dynamic>> result =
        await collection.add(fieldsMap);
    return result.id;
  }

  // update 1 record
  Future updateRecord(String id, Map<String, dynamic> data) async {
    await collection.doc(id).update(data);
  }

  // delete 1 record
  Future deleteRecord(String id) async {
    await collection.doc(id).delete();
  }

// ----- BULK DML -----
  // bulk create
  Future createRecords(List<DBObject> dbObjects) async {
    if (dbObjects.isEmpty) return;
    WriteBatch batch = db.batch();
    for (DBObject dbObj in dbObjects) {
      var docRef = collection.doc();
      batch.set(docRef, dbObj.toMap());
    }
    await batch.commit();
  }

  // bulk update
  Future updateRecords(List<DBObject> dbObjects) async {
    if (dbObjects.isEmpty) return;
    WriteBatch batch = db.batch();
    for (DBObject dbObj in dbObjects) {
      DocumentReference docRef = collection.doc(dbObj.id);
      batch.update(docRef, dbObj.toMap());
    }
    await batch.commit();
  }

  // bulk delete by records ids
  Future deleteRecordsByIds(Set<String> ids) async {
    if (ids.isEmpty) return;
    WriteBatch batch = db.batch();
    for (String id in ids) {
      DocumentReference docRef = collection.doc(id);
      batch.delete(docRef);
    }
    await batch.commit();
  }

// ----- QUERY RECORDS -----
  // query record by its id
  Future<DocumentSnapshot<Object?>> queryRecordById(String id) async {
    DocumentReference docRef = collection.doc(id);
    return await docRef.get();
  }

  // query records by filters
  Future<List<QueryDocumentSnapshot<Object?>>> queryRecords(
      List<QueryFilter> filters) async {
    Query<Map<String, dynamic>> query = _addFilters(filters);
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs;
  }

  // add filters to a query
  Query<Map<String, dynamic>> _addFilters(List<QueryFilter> filters) {
    dynamic query = collection;
    if (filters.isNotEmpty) {
      for (QueryFilter filter in filters) {
        if (filter is BoolQueryFilter) {
          query = query.where(filter.field, isEqualTo: filter.value);
        } else if (filter is StringQueryFilter) {
          if (filter.operator == StringQueryOperator.equal) {
            query = query.where(filter.field, isEqualTo: filter.value);
          }
        }
      }
    }
    return query;
  }

// ----- FILTER RECORDS -----
  // filters DBObject list by ids
  List<DBObject> filterDBObjectsByIds(
      List<DBObject> dbObjectsToFilter, Set<String> ids) {
    if (ids.isEmpty) return [];
    List<DBObject> filteredDBObjects = [
      for (var v in dbObjectsToFilter)
        if (ids.contains(v.id)) v
    ];
    return filteredDBObjects;
  }
}
