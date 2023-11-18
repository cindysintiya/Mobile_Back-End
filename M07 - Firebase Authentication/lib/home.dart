import 'package:flutter/material.dart';
import 'package:case_study_latihan/auth.dart';
import 'package:case_study_latihan/login_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key, required this.wid, required this.email});

  final String wid;
  final String? email;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late AuthFirebase auth;

  @override
  void initState() {
    super.initState();
    auth = AuthFirebase();
    auth.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Authentication"),
        actions: [
          IconButton(
            onPressed: () {
              auth.logout();
              final route = MaterialPageRoute(builder: (context) =>  const LoginScreen());
              Navigator.pushReplacement(context, route);
            }, 
            icon: const Icon(Icons.logout_rounded),
            tooltip: "Logout",
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome ${widget.email}"),
            Text("ID ${widget.wid}")
          ],
        ),
      ),
    );
  }
}