/* Helpful dart code to work with Firebase Auth features (User objects)
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/ui/screens/auth/login_screen.dart';

class FirebaseAuthService {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static User? get user => auth.currentUser;
  static String? get userId => user?.uid;
  static bool get loggedIn => auth.currentUser != null;

  // on user logged out event => navigate to login page
  static void listenUserLoggedOut() {
    auth.idTokenChanges().listen((User? user) async {
      if (user == null) {
        await NavigationService.clearRouteAndPushNamed(LoginScreen.id, null);
      }
    });
  }

  // returns uid if user is logged in, otherwise - navigate to login page
  static String? getUserIdIfLoggedIn() {
    if (!loggedIn) {
      NavigationService.clearRouteAndPushNamed(LoginScreen.id, null);
      return null;
    }
    return userId!;
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
        passwordLength: 8,
        specialChar: true,
        uppercase: true);
    return newPassword;
  }

  // create a new user without sighning in right after the creation
  static Future<User?> createUserWithoutSigningIn(String email) async {
    String password = FirebaseAuthService.generatePassword();
    FirebaseApp app = await Firebase.initializeApp(
        name: 'CreateStudent', options: Firebase.app().options);
    UserCredential newUserCred = await FirebaseAuth.instanceFor(app: app)
        .createUserWithEmailAndPassword(email: email, password: password);
    return newUserCred.user;
  }

  // log out
  static Future logOut() async => await auth.signOut();
  // update user name
  static Future updateUserName(String newName) async =>
      await user?.updateDisplayName(newName);
  // update user email
  static Future updateUserEmail(String newEmail) async =>
      await user?.updateEmail(newEmail);
  // update user avatar photo url
  static Future updateUserPhotoURL(String newURL) async =>
      await user?.updatePhotoURL(newURL);
}
