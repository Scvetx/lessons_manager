/* Custom Widget - a cell item with info about 1 scheduled lesson
*/

import 'package:flutter/material.dart';

import 'package:workbook/models/student.dart';
import 'package:workbook/ui/screens/students/student_view_screen.dart';

class ScheduleItemCmp extends StatelessWidget {
  Student curStudent;
  ScheduleItemCmp(this.curStudent);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, StudentViewScreen.id,
              arguments: curStudent);
        },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(
                      //color: curStudent.languageLevel.getFrameColor(),
                      ),
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Text(
                  //curStudent.languageLevel.parseToString(),
                  curStudent.languageLevel!.value,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    //color: curStudent.languageLevel.getLabelColor()
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              curStudent.name.value,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, StudentViewScreen.id,
                      arguments: curStudent);
                },
                icon: Icon(Icons.edit)),
          ],
        ));
  }
}
