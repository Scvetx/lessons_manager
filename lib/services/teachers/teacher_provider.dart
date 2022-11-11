/* functions dml/query teachers
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workbook/services/app/firebase/firebase_collection.dart';
import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/models/teacher.dart';

class TeacherProvider extends FirebaseCollection {
  TeacherProvider() : super(collectionName: 'teachers');

// - QUERY RECORDS -
  // query teachers by filters
  Future<List<Teacher>> queryTeachers(List<QueryFilter> filters) async {
    List<Teacher> records = [];
    var docs = await queryRecords(filters);
    for (QueryDocumentSnapshot<Object?> doc in docs) {
      Map<String, dynamic> objMap = doc.data() as Map<String, dynamic>;
      Teacher rec = Teacher.fromMap(objMap);
      rec.id = doc.id;
      records.add(rec);
    }
    return records;
  }
}
