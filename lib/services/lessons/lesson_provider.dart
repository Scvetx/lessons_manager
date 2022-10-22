import 'package:workbook/services/app/firebase/firebase_collection.dart';
import 'package:workbook/models/lesson.dart';

class LessonProvider extends FirebaseCollection {
  LessonProvider() : super(collectionName: 'lessons');

// - QUERY RECORDS -
  Future<List<Lesson>> queryLessons(Map<String, String> whereMap) async {
    List<Lesson> records = [];
    var docs = await queryRecords(whereMap);
    for (var doc in docs) {
      Map<String, dynamic> objMap = doc.data() as Map<String, dynamic>;
      Lesson rec = Lesson.fromMap(objMap);
      rec.id = doc.id;
      records.add(rec);
    }
    return records;
  }
}
