/* functions dml/query courses
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workbook/services/app/firebase/firebase_collection.dart';
import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/models/course.dart';

class CourseProvider extends FirebaseCollection {
  CourseProvider() : super(collectionName: 'courses');

// -- QUERY RECORDS --
  // query courses by filters
  Future<List<Course>> queryCourses(List<QueryFilter> filters) async {
    List<Course> records = [];
    var docs = await queryRecords(filters);
    for (var doc in docs) {
      Map<String, dynamic> objMap = doc.data() as Map<String, dynamic>;
      Course rec = Course.fromMap(objMap);
      rec.id = doc.id;
      records.add(rec);
    }
    return records;
  }

  // query course by course id
  Future<Course> queryCourseById(String id) async {
    DocumentSnapshot<Object?> doc = await queryRecordById(id);
    Map<String, dynamic> objMap = doc.data() as Map<String, dynamic>;
    Course rec = Course.fromMap(objMap);
    rec.id = doc.id;
    return rec;
  }
}
