import 'profile.dart';

class Teacher extends Profile {
// ----- STATIC -----
  static const String label = 'Teacher';

// ----- FIELDS -----
  late String userId; // teacher's User id

// ----- CONSTRUCTORS -----
  // creates an new Teacher with empty fields: used on registration_screen
  Teacher.create();

  // parse db map to Teacher obj
  Teacher.fromMap(Map<String, dynamic> objMap)
      : userId = objMap['userId'] ?? '',
        super.fromMap(objMap);

// ----- DB METHODS -----
  // convert Teacher to db map
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({
      'userId': userId,
    });
    return map;
  }

// ----- COPY OBJECT METHOD -----
  // returns current Teacher obj copy as a new Instance of Teacher
  // used while updating Teacher to store the old value
  Profile copy() {
    Map<String, dynamic> objMap = toMap();
    Teacher copy = Teacher.fromMap(objMap);
    copy.id = id;
    return copy;
  }
}
