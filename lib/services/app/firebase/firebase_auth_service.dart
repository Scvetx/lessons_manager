/* Helpful dart code to work with Firebase Auth features (User objects)
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/teachers/teacher_repository.dart';
import 'package:workbook/services/students/student_repository.dart';

import 'package:workbook/models/teacher.dart';
import 'package:workbook/models/student.dart';
import 'package:workbook/ui/screens/auth/login_screen.dart';

class FirebaseAuthService {
  static bool get isTeacher => teacher != null;

  static Teacher? teacher;
  static String? get teacherId => teacher?.id;

  static Student? student;
  static String? get studentId => student?.id;

  static Future initUserProfile() async {
    if (userId == null) return;
    TeacherRepository teacherRepo = TeacherRepository();
    teacher = await teacherRepo.queryTeacherByUserId(userId!);
    if (teacher != null) return;
    StudentRepository studentRepo = StudentRepository();
    student = await studentRepo.queryStudentByUserId(userId!);
    initStudentDataIfFirstLogin();
  }

  static Future initStudentDataIfFirstLogin() async {
    if (!student!.isVerified) {
      StudentRepository repo = StudentRepository();
      await FirebaseAuthService.updateUserName(student!.name.value);
      Student newStudent = student!.copy(isVerified: true);
      await repo.updateRecord(newStudent, student!);
    }
  }

  static void clearUserProfile() {
    teacher = null;
    student = null;
  }

  static Future updateUserProfile(
      dynamic newProfile, dynamic oldProfile) async {
    if (FirebaseAuthService.isTeacher) {
      TeacherRepository repo = TeacherRepository();
      await repo.updateRecord(newProfile);
      teacher = newProfile.copy();
    } else {
      StudentRepository repo = StudentRepository();
      await repo.updateRecord(newProfile, oldProfile);
      student = newProfile.copy();
    }
  }

  static FirebaseAuth get auth => FirebaseAuth.instance;
  static User? get user => auth.currentUser;
  static String? get userId => user?.uid;
  static bool get loggedIn => auth.currentUser != null;

  // on user logged out event => navigate to login page
  static void listenUserLoggedOut() {
    auth.idTokenChanges().listen((User? user) async {
      if (user == null) {
        toLoginScreen();
      }
    });
  }

  // returns uid if user is logged in, otherwise - navigate to login page
  static String? getUserIdIfLoggedIn() {
    if (!loggedIn) {
      toLoginScreen();
      return null;
    }
    return userId!;
  }

  static void toLoginScreen() {
    clearUserProfile();
    NavigationService.clearRouteAndPushNamed(LoginScreen.id, null);
  }

  // returns true id user is logged in; otherwise - false
  static bool checkUserLoggedIn() {
    String? uid = getUserIdIfLoggedIn();
    return uid != null;
  }

  // additional authenticate user  (if sesnitive user data is being changed)
  static Future<void> reauthenticateUser(String password) async {
    bool sessionActive = checkUserLoggedIn();
    if (sessionActive) {
      String email = user!.email!;
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user!.reauthenticateWithCredential(credential);
    }
  }

  // generate a random password with 8 chars
  static String generatePassword() {
    RandomPasswordGenerator passwordGenerator = RandomPasswordGenerator();
    String newPassword = passwordGenerator.randomPassword(
        letters: true,
        numbers: true,
        passwordLength: 6,
        specialChar: false,
        uppercase: true);
    return newPassword;
  }

  // create a new user without sighning in right after the creation
  static Future<User?> createUserWithoutSigningIn(
      String email, String password) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'CreateStudent', options: Firebase.app().options);
    UserCredential newUserCred = await FirebaseAuth.instanceFor(app: app)
        .createUserWithEmailAndPassword(email: email, password: password);
    return newUserCred.user;
  }

  // log out
  static Future logOut() async {
    await auth.signOut();
    clearUserProfile();
  }

  // update user name
  static Future updateUserName(String newName) async =>
      await user?.updateDisplayName(newName);
  // update user email
  static Future updateUserEmail(String newEmail) async =>
      await user?.updateEmail(newEmail);
  // update user avatar photo url
  static Future updateUserPhotoURL(String newURL) async =>
      await user?.updatePhotoURL(newURL);
  // update user password
  static Future updatePassword(String newPassword) async =>
      await user?.updatePassword(newPassword);
}
