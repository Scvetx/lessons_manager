/* A Layout to show lock a screen while waiting for some process
*/

import 'package:flutter/material.dart';
import 'package:workbook/ui/components/app/menu/app_menu_cmp.dart';

class LoadingLayout extends StatelessWidget {
  final String title;
  LoadingLayout({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          AppMenuCmp(),
        ],
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
