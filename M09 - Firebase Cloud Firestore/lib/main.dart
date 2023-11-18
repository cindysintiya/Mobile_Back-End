import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:case_study_latihan/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('init done');
  FirebaseFirestore db = FirebaseFirestore.instance;
  print('init Firestore done');
  await db.collection('event_detail').get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} ${doc.data()}");
    }
  });
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHome(),
    );
  }
}
