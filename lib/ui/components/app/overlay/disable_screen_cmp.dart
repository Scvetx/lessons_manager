/* Custom Widget - used to disable screen when waiting for some process to finish
*/

import 'package:flutter/material.dart';

class DisableScreenCmp extends StatelessWidget {
  final Widget child;
  late bool disable;
  DisableScreenCmp({required this.child, this.disable = true});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IgnorePointer(ignoring: disable, child: child),
      Visibility(
        visible: disable,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.withOpacity(0.3),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    ]);
  }
}
