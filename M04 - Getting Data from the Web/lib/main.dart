import 'package:case_study_latihan/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '211110347 - Cindy Sintiya',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary, // appbar

      ),
      debugShowCheckedModeBanner: false,
      home: const MyHome(),
    );
  }
}