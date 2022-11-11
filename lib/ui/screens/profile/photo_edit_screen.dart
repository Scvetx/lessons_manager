/* A page to edit a photo on profile
*/

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/models/profile.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/menu/app_menu_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';
import 'package:workbook/ui/components/app/buttons/outlined_rounded_button_cmp.dart';

class PhotoEditScreen extends StatefulWidget {
  static const String id = 'photo_edit_screen';

  @override
  _PhotoEditScreenState createState() => _PhotoEditScreenState();
}

class _PhotoEditScreenState extends State<PhotoEditScreen> {
  User get _curUser => FirebaseAuthService.user!;
  File? _photoFile;
  bool _uploading = false;

  Future uploadPhoto() async {
    try {
      setState(() {
        _uploading = true;
      });
      String path = 'avatars/${_curUser.uid}';
      var ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(_photoFile!);
      String photoURL = await ref.getDownloadURL();
      await _curUser.updatePhotoURL(photoURL);
      setState(() {
        _uploading = false;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarCmp(text: e.toString()));
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path); //File(image.path);
      setState(() => _photoFile = imageTemp);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarCmp(text: e.toString()));
    }
  }

  void changePic() async {
    try {
      await pickImage();
      if (_photoFile != null) await uploadPhoto();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarCmp(text: e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();

    return Scaffold(
      appBar: AppBar(
        title: const Text('$labelMy ${Profile.fPhotoLabel}'),
        actions: [
          AppMenuCmp(),
        ],
      ),
      body: ScreenContainerCmp(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Visibility(
            visible: !_uploading,
            child: Column(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Image(
                  image: NetworkImage(
                    _curUser.photoURL ?? 'No photo',
                  ),
                ),
              ),
              const SizedBox(height: spaceBetweenLines),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: OutlinedRoundedButtonCmp(
                  title: '$labelChange ${Profile.fPhotoLabel}',
                  onPressed: changePic,
                ),
              ),
            ]),
          ),
          Visibility(
            visible: _uploading,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ]),
      ),
    );
  }
}
