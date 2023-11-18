import 'package:flutter/material.dart';
import 'package:case_study_latihan/teori/Helper/authentication.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late AuthenticationHelper auth;

  @override
  void initState() {
    super.initState();
    auth = AuthenticationHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome ${auth.user.email} to Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          auth.logout();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
        },
        tooltip: 'Logout',
        child: const Icon(Icons.logout),
      ),
    );
  }
}
