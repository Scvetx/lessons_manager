/* Custom Widget - a listview used to present a list of records on the screen
*/

import 'package:flutter/material.dart';
import 'package:workbook/ui/components/app/list/list_row_cmp.dart';

class ListCmp extends StatelessWidget {
  final List<Widget> rows;
  ListCmp({required this.rows});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: rows.length,
      itemBuilder: (BuildContext context, int i) {
        return ListRowCmp(row: rows[i]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
