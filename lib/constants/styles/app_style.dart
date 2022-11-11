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
    backgroundColor: defaultHeaderColor,
  ),
);
// -- header --
const Color defaultHeaderColor = Color(0xFF006e8c);

// -- padding --
const EdgeInsets screenPadding =
    EdgeInsets.symmetric(horizontal: 24, vertical: 24);

// -- sized box --
const double spaceBetweenLines = 24;
const double spaceBetweenLinesSmall = 14;
const double spaceBetweenLinesLarge = 34;

// -- buttons --
const Color greyIconColor = Color(0x70BDBDBD);
const Color defaultButtonColor = Color(0xFF008db1);
const EdgeInsets defaultButtonPadding =
    EdgeInsets.symmetric(vertical: 14, horizontal: 22);
const double roundedButtonRadius = 50;

// -- text --

const TextStyle whiteText = TextStyle(
  color: Colors.white,
);
const greyTextColor = Color(0xFF929191);

const TextStyle mBlackText = TextStyle(fontSize: 14, color: Colors.black);
const TextStyle mBlackLabel =
    TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);

const TextStyle mBlackLongText =
    TextStyle(fontSize: 14, color: Colors.black, height: 1.5);

const TextStyle mGreyText = TextStyle(fontSize: 14, color: greyTextColor);
const TextStyle mGreyLabel =
    TextStyle(fontSize: 14, color: greyTextColor, fontWeight: FontWeight.bold);

const TextStyle sGreyText = TextStyle(fontSize: 12, color: greyTextColor);

// -- input text --
const inputTextDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
