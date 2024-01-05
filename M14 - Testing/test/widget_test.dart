// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:case_study_latihan/main.dart';

void main() {
  testWidgets('Test Text Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // expect : mengecek kesesuaian widget dengan yang seharusnya
    // find : mencari widget yang akan Anda uji berdasarkan kriteria tertentu
    expect(find.text("COUNTER"), findsOneWidget);   // findsOneWidget : memastikan kriteria yang Anda cari setidaknya terdapat pada satu dari keseluruhan widget
    expect(find.text("Dec"), findsOneWidget);
    expect(find.text("Kurang"), findsNothing);   // findsNothing : memastikan kriteria yang Anda cari tidak boleh ada pada keseluruhan widget
    expect(find.text("0"), findsOneWidget);
    expect(find.text("Inc"), findsOneWidget);
    expect(find.text("Tambah"), findsNothing);
    expect(find.text("REVERSE TEXT"), findsOneWidget);
    expect(find.text("Reverse"), findsOneWidget);
  });

  testWidgets('Test Counter', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text("0"), findsOneWidget);   // text awal sebelum di apa" in

    // tester.tap : melakukan uji coba dengan aksi klik terhadap widget
    await tester.tap(find.byKey(const Key("btnInc")));   // find.byKey : mencari widget berdasarkan key yang Anda gunakan
    await tester.pump();
    expect(find.text("1"), findsOneWidget);  // tekan + 1x, harapannya dr 0 jd 1

    await tester.tap(find.widgetWithText(ElevatedButton, "Dec"));   // find.widgetWithText : mencari widget yang memiliki child Text sesuai kriteria
    await tester.tap(find.widgetWithText(ElevatedButton, "Dec"));
    await tester.pump();
    expect(find.text("1"), findsNothing);   // tekan - 2x, harapannya bkn ttp angka 1
    expect(find.text("-1"), findsOneWidget);   // tekan - 2x, harapannya dr 0 jd -1
  });

  testWidgets('Test Reverse Text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.byType(TextField), findsOneWidget);   // find.byType : mencari widget berdasarkan tipe widget
    await tester.enterText(find.byType(TextField), "Back End Flutter");   // tester.enterText : melakukan uji coba dengan aksi input terhadap widget
    await tester.tap(find.widgetWithText(ElevatedButton, "Reverse"));
    await tester.pump();
    expect(find.text("rettulF dnE kcaB"), findsOneWidget);
  });

}
