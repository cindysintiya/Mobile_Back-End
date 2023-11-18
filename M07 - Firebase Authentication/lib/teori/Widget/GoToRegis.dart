import 'package:flutter/material.dart';
import 'package:case_study_latihan/teori/signUp.dart';

class RegistNav extends StatefulWidget {
  const RegistNav({super.key});

  @override
  State<RegistNav> createState() => _RegistNavState();
}

class _RegistNavState extends State<RegistNav> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Have no Account? ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Signup()));
          },
          child: const Text('Register Now!',
              style: TextStyle(fontSize: 16, color: Colors.blue)),
        )
      ],
    );
  }
}
