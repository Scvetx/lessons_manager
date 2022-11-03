/* functions dml/query students
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workbook/services/app/firebase/firebase_collection.dart';
import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/models/student.dart';

class StudentProvider extends FirebaseCollection {
  StudentProvider() : super(collectionName: 'students');

// - QUERY RECORDS -
  // query students by filters
  Future<List<Student>> queryStudents(List<QueryFilter> filters) async {
    List<Student> records = [];
    var docs = await queryRecords(filters);
    for (QueryDocumentSnapshot<Object?> doc in docs) {
      Map<String, dynamic> objMap = doc.data() as Map<String, dynamic>;
      Student rec = Student.fromMap(objMap);
      rec.id = doc.id;
      records.add(rec);
    }
    return records;
  }
}
