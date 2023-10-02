import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:case_study_latihan/my_provider.dart';
import 'package:case_study_latihan/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListProductProvider(),
      child: MaterialApp(
        title: '211110347 - Cindy Sintiya',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true
        ),
        debugShowCheckedModeBanner: false,
        home: const Screen(),
      ),
    );
  }
}