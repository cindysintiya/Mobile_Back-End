import 'package:flutter/material.dart';
import 'package:case_study_latihan/teori/Widget/GoToLogin.dart';
import 'package:case_study_latihan/teori/Widget/SignUpForm.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const SizedBox(height: 80),
          const Text(
            "Welcome!",
            style: TextStyle(fontSize: 24),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SignupForm(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: const LoginNav()
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

