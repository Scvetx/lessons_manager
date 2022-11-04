import 'package:flutter/material.dart';

class LanguageLevel {
// ----- FIELDS -----
  late String value;
  late Color labelColor;
  late Color frameColor;

// ----- CONSTRUCTORS -----
  LanguageLevel(this.value) {
    _setLabelColor();
    _setFrameColor();
  }

// ----- GET COLOR METHODS -----
  void _setLabelColor() {
    switch (value) {
      case 'A0':
      case 'A1':
      case 'A2':
        {
          labelColor = Colors.green;
        }
        break;
      case 'B1':
      case 'B2':
        {
          labelColor = Colors.orange;
        }
        break;
      case 'C1':
      case 'C2':
        {
          labelColor = Colors.deepPurple;
        }
        break;
      default:
        {
          labelColor = Colors.grey;
        }
        break;
    }
  }

  void _setFrameColor() {
    switch (value) {
      case 'A0':
      case 'A1':
      case 'A2':
        {
          frameColor = Colors.green;
        }
        break;
      case 'B1':
      case 'B2':
        {
          frameColor = Colors.orange;
        }
        break;
      case 'C1':
      case 'C2':
        {
          frameColor = Colors.deepPurple;
        }
        break;
      default:
        {
          frameColor = Colors.grey;
        }
        break;
    }
  }

// ----- CUSTOM OPERATORS -----
  bool operator >(LanguageLevel other) => value.compareTo(other.value) == 1;
  bool operator <(LanguageLevel other) => value.compareTo(other.value) == -1;
}
