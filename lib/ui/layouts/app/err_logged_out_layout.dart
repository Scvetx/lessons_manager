/* A Layout to show an error when user is logged out
*/

import 'package:flutter/material.dart';
import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/components/app/buttons/link_text.dart';
import 'package:workbook/ui/screens/auth/login_screen.dart';

class ErrLoggedOutCmp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(errNotLoggedIn),
              const SizedBox(width: spaceBetweenLinesSmall),
              LinkText(
                text: labelLoginButton,
                onPressed: () {
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                },
              ),
            ]),
      ]),
    );
  }
}
