import 'package:workbook/services/app/firebase/firebase_collection.dart';
import 'package:workbook/models/course.dart';

class CourseProvider extends FirebaseCollection {
  CourseProvider() : super(collectionName: 'courses');

// -- QUERY RECORDS --
  Future<List<Course>> queryCourses(Map<String, String> whereMap) async {
    List<Course> records = [];
    var docs = await queryRecords(whereMap);
    for (var doc in docs) {
      Map<String, dynamic> objMap = doc.data() as Map<String, dynamic>;
      Course rec = Course.fromMap(objMap);
      rec.id = doc.id;
      records.add(rec);
    }
    return records;
  }
}
