import 'package:flutter/material.dart';

class LoginNav extends StatefulWidget {
  const LoginNav({super.key});

  @override
  State<LoginNav> createState() => _LoginNavState();
}

class _LoginNavState extends State<LoginNav> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Have Account? ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text("Login!",
              style: TextStyle(fontSize: 18, color: Colors.blue)),
        )
      ],
    );
  }
}
