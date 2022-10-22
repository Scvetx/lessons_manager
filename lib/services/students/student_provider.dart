import 'package:workbook/services/app/firebase/firebase_collection.dart';
import 'package:workbook/models/student.dart';

class StudentProvider extends FirebaseCollection {
  StudentProvider() : super(collectionName: 'students');

// - QUERY RECORDS -
  Future<List<Student>> queryStudents(Map<String, String> whereMap) async {
    List<Student> records = [];
    var docs = await queryRecords(whereMap);
    for (var doc in docs) {
      Map<String, dynamic> objMap = doc.data() as Map<String, dynamic>;
      Student rec = Student.fromMap(objMap);
      rec.id = doc.id;
      records.add(rec);
    }
    return records;
  }
}
