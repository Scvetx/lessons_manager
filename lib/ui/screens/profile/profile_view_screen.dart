/* A page where a teacher can view the teacher's card
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/models/profile.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/object_view_style.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/app/menu/app_menu_cmp.dart';
import 'package:workbook/ui/screens/profile/photo_edit_screen.dart';
import 'profile_form_screen.dart';

class ProfileViewScreen extends StatefulWidget {
  static const String id = 'profile_view_screen';

  @override
  _ProfileViewScreenState createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  bool _loggingOut = false;

  void logOut() async {
    setState(() => _loggingOut = true);
    try {
      await FirebaseAuthService.logOut();
    } on Exception catch (e) {
      setState(() => _loggingOut = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarCmp(text: e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) ErrLoggedOutCmp();

    return Scaffold(
      appBar: AppBar(
        title: const Text('$labelMy ${Profile.label}'),
        actions: [
          AppMenuCmp(),
        ],
      ),
      body: ScreenContainerCmp(
        child: StreamBuilder<User?>(
            stream: FirebaseAuthService.auth.userChanges(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();

              User user = snapshot.data as User;
              Profile profile = Profile.fromUser(user);

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.only(right: 24),
                        child: InkResponse(
                          onTap: () {
                            Navigator.pushNamed(context, PhotoEditScreen.id);
                          },
                          child: CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(profile.photoURL)),
                        ),
                      ),
                      Expanded(
                        child:
                            Text(profile.name.value, style: ovTitleLargeStyle),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          iconSize: 16,
                          onPressed: () {
                            Navigator.pushNamed(context, ProfileFormScreen.id,
                                arguments: user);
                          },
                        ),
                      ),
                    ]),
                    const SizedBox(height: spaceBetweenLines),
                    Row(children: [
                      SizedBox(
                        width: ovFirstColumnWidth,
                        child: Text('${Profile.fEmailLabel}:',
                            style: ovFieldLabelStyle),
                      ),
                      Text(profile.email.value),
                    ]),
                  ]); //,
            }),
      ),
      bottomNavigationBar: BottomButtonCmp(
          title: labelLogOut,
          color: Colors.redAccent,
          onPressed: _loggingOut ? null : logOut),
    );
  }
}
