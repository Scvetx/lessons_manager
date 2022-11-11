import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workbook/services/app/firebase/firebase_options.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/app/navigation/locator.dart';

import 'package:workbook/constants/home_screen_id.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/screens/auth/login_screen.dart';
import 'package:workbook/ui/screens/auth/registration_screen.dart';
import 'package:workbook/ui/screens/profile/profile_form_screen.dart';
import 'package:workbook/ui/screens/profile//profile_view_screen.dart';
import 'package:workbook/ui/screens/profile/photo_edit_screen.dart';
import 'package:workbook/ui/screens/profile/password_update_screen.dart';
import 'package:workbook/ui/screens/students/students_screen.dart';
import 'package:workbook/ui/screens/students/student_form_screen.dart';
import 'package:workbook/ui/screens/students/student_view_screen.dart';
import 'package:workbook/ui/screens/lessons/lessons_screen.dart';
import 'package:workbook/ui/screens/lessons/lesson_form_screen.dart';
import 'package:workbook/ui/screens/lessons/lesson_view_screen.dart';
import 'package:workbook/ui/screens/courses/courses_screen.dart';
import 'package:workbook/ui/screens/courses/course_form_screen.dart';
import 'package:workbook/ui/screens/courses/course_view_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuthService.listenUserLoggedOut();
  await FirebaseAuthService.initUserProfile();
  runApp(Workbook());
}

class Workbook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String initRoute =
        FirebaseAuthService.loggedIn ? homeScreenId : LoginScreen.id;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      theme: appTheme,
      initialRoute: initRoute,
      navigatorKey: Locator.navigatorKey,
      routes: {
        // auth
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),

        // profile
        ProfileFormScreen.id: (context) => ProfileFormScreen(),
        ProfileViewScreen.id: (context) => ProfileViewScreen(),
        PhotoEditScreen.id: (context) => PhotoEditScreen(),
        PasswordUpdateScreen.id: (context) => PasswordUpdateScreen(),

        // students
        StudentsScreen.id: (context) => StudentsScreen(),
        StudentFormScreen.id: (context) => StudentFormScreen(),
        StudentViewScreen.id: (context) => StudentViewScreen(),

        // lessons
        LessonsScreen.id: (context) => LessonsScreen(),
        LessonFormScreen.id: (context) => LessonFormScreen(),
        LessonViewScreen.id: (context) => LessonViewScreen(),

        // courses
        CoursesScreen.id: (context) => CoursesScreen(),
        CourseFormScreen.id: (context) => CourseFormScreen(),
        CourseViewScreen.id: (context) => CourseViewScreen(),
      },
    );
  }
}
