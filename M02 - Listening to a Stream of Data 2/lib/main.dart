import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:case_study_latihan/mybio_provider.dart';
import 'package:case_study_latihan/challenge/mybio_provider.dart';
// import 'package:case_study_latihan/mybio.dart';
// import 'package:case_study_latihan/mybio_latihan.dart';
import 'package:case_study_latihan/challenge/mybio_latihan.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyBioProvider()),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '211110347 - Cindy Sintiya',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      home: const MyBio(),
    );
  }
}