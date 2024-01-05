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
  // EXERCISE
  testWidgets('Test Tebak Warna', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const Key("pindahExercise")));   // pindah halaman
    await tester.pumpAndSettle();  // menunggu hingga semua animasi selesai
    
    expect(find.text("Tebak Warna"), findsOneWidget);   // klo judul sudah ketemu
    expect(find.byType(Image), findsOneWidget);   // klo gambar ud ketemu
    await tester.tap(find.widgetWithText(RadioListTile, "Merah"));   // tunggu dia pilih jawaban
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);   // alert konfirmasi
    // expect(find.byWidget(const AlertDialog()), findsOneWidget);   // alert konfirmasi; gbs gtau kenapa
    await tester.tap(find.widgetWithText(TextButton, "Kirim"));   // kirim jawaban
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);   // jawaban hrs benar
    expect(find.byIcon(Icons.cancel_rounded), findsNothing);   // tdk boleh salah
  });
}
