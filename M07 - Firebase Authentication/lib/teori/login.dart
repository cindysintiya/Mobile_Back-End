import 'package:flutter/material.dart';
import 'package:case_study_latihan/teori/Widget/LoginForm.dart';
import 'Widget/GoToRegis.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const <Widget>[
          SizedBox(height: 80),
          Column(
            children: [
              SizedBox(height: 50),
              Text(
                'Welcome!',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: LoginForm(),
          ),
          SizedBox(height: 20),
          RegistNav(),
        ],
      ),
    );
  }
}

