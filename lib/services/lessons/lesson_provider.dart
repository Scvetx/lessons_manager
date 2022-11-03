/* functions dml/query lessons
*/

import 'package:workbook/services/app/firebase/firebase_collection.dart';
import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/models/lesson.dart';

class LessonProvider extends FirebaseCollection {
  LessonProvider() : super(collectionName: 'lessons');

// - QUERY RECORDS -
  // query lessons by filters
  Future<List<Lesson>> queryLessons(List<QueryFilter> filters) async {
    List<Lesson> records = [];
    var docs = await queryRecords(filters);
    for (var doc in docs) {
      Map<String, dynamic> objMap = doc.data() as Map<String, dynamic>;
      Lesson rec = Lesson.fromMap(objMap);
      rec.id = doc.id;
      records.add(rec);
    }
    return records;
  }
}
