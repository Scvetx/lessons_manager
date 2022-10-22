/* global styles to use across the app
*/

import 'package:flutter/material.dart';

// -- THEME --
ThemeData appTheme = ThemeData(
  // default brightness and colors.
  brightness: Brightness.light,
  // default font family.
  fontFamily: 'Hind',

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF006e8c),
  ),
);

// -- padding --
const EdgeInsets screenPadding =
    EdgeInsets.symmetric(horizontal: 24, vertical: 24);
const doubleformPadding = 24;

// -- sized box --
const double spaceBetweenLines = 24;
const double spaceBetweenLinesSmall = 14;
const double spaceBetweenLinesLarge = 34;

// -- buttons --
const Color defaultButtonColor = Color(0xFF008db1);
const EdgeInsets defaultButtonPadding = EdgeInsets.all(14);
const double roundedButtonRadius = 50;

// -- text --
const TextStyle whiteText = TextStyle(
  color: Colors.white,
);

// -- input text --
const inputTextDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
);
