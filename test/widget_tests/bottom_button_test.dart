import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';

void main() async {
  await testInit();
  await testTap();
}

Future testInit() async {
  testWidgets('when widget init :: number = 0', (WidgetTester tester) async {
    // -- prepare test data --
    int testValue = 0;
    onTap() => testValue++;
    BottomButtonCmp widget = getWidget(onTap);

    // -- do test actions --
    await initWidget(tester, widget, testValue);

    // -- check widgets rendered --
    expect(find.byType(BottomButtonCmp), findsOneWidget);
    expect(find.text('test btn'), findsOneWidget);

    // -- check values --
    expect(testValue, 0); // init value = 0
  });
}

Future testTap() async {
  testWidgets('when single tapped - increment number',
      (WidgetTester tester) async {
    // -- prepare test data --
    int testValue = 0;
    onTap() => testValue++;
    BottomButtonCmp widget = getWidget(onTap);

    // -- do test actions --
    await initWidget(tester, widget, testValue);
    await tapWidget(tester, widget, testValue);

    // -- check values --
    expect(testValue, 1); // incremented value = 1
  });
}

BottomButtonCmp getWidget(GestureTapCallback? onTap) {
  return BottomButtonCmp(
    title: 'test btn',
    onPressed: onTap,
  );
}

Future initWidget(WidgetTester tester, Widget widget, int testValue) async {
  await tester.pumpWidget(MaterialApp(home: widget));
}

Future tapWidget(WidgetTester tester, Widget widget, int testValue) async {
  await tester.tap(find.byType(BottomButtonCmp));
  await tester.pump();
}
