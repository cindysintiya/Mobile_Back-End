import 'package:flutter/material.dart';

import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:case_study_latihan/auth.dart';
import 'package:case_study_latihan/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthFirebase auth;

  @override
  void initState() {
    super.initState();
    auth = AuthFirebase();
    auth.getUser().then((value) {
      MaterialPageRoute route;
      if (value != null) {
        route = MaterialPageRoute(builder: (context) => MyHome(wid: value.uid, email: value.email,));
        Navigator.pushReplacement(context, route);
      }
    }).catchError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: _loginUser, 
      onRecoverPassword: _recoverPassword,
      onSignup: _onSignUp,
      passwordValidator: (value) {
        // untuk menentukan regex dari kata sandi yang diterima
        if (value != null && value.length < 6) {
          return "Password Must be 6 Characters";
        }
        return null; // coba dulu, klo gbs, hapus!
      },
      loginProviders: <LoginProvider>[
        //  menyediakan tombol tambahan Ketika user ingin melakukan login menggunakan mekanisme kredensial seperti Google, Facebook, Twitter, Microsoft, dan lainnya
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: "Google",
          callback: _onLoginGoogle
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebook,
          label: "Facebook",
          callback: _onLoginFacebook
        )
      ],
      onSubmitAnimationCompleted: () {
        // listener yang dijalankan ketika pengguna menekan tombol submit
        auth.getUser().then((value) {
          MaterialPageRoute route;
          if (value != null) {
            route = MaterialPageRoute(builder: (context) => MyHome(wid: value.uid, email: value.email,));
          } else {
            route = MaterialPageRoute(builder: (context) =>  const LoginScreen());
          }
          Navigator.pushReplacement(context, route);
        }).catchError((err) => print(err));
      },
    );
  }
  
  Future<String?> _loginUser(LoginData data) {
    // memproses login dengan mengirimkan sebuah fungsi Future dengan parameter LoginData yang berisikan data user name/email dan password yang diisikan oleh user pada proses login
    return auth.login(data.name, data.password).then((value) {
      if (value != null) {
        MaterialPageRoute(builder: (context) => MyHome(wid: value, email: value,));
      } else {
        final snackBar = SnackBar(
          content: const Text("Login Failed, User Not Found"),
          action: SnackBarAction(
            label: "OK", 
            onPressed: () {
              // code to undo the change
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          ),
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }).catchError((err) => print(err));
  }

  Future<String?>? _recoverPassword(String name) {
    // memproses lupa sandi dengan mengirimkan sebuah fungsi Future dengan parameter String yang berisikan data user name/email diisikan oleh user pada lupa sandi
    return auth.resetPassword(name).then((value) {
      if (value!=null) {
        final snackBar = SnackBar(
          content: const Text("Password reset email sent. Check your email inbox."),
          action: SnackBarAction(
            label: "OK", 
            onPressed: () {
              // code to undo the change
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }).catchError((err) => print(err));
  }

  Future<String?>? _onSignUp(SignupData data) {
    // memproses pendaftaran dengan mengirimkan sebuah fungsi Future dengan parameter SignupData yang berisikan data name, password dan termsOfService yang diisikan oleh user pada proses pendaftaran
    return auth.signUp(data.name!, data.password!).then((value) {
      if (value != null) {
        final snackBar = SnackBar(
          content: const Text("Sign Up Successful"),
          action: SnackBarAction(
            label: "OK", 
            onPressed: () {
              // code to undo the change
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }).catchError((err) => print(err));
  }

  Future<String?>? _onLoginGoogle() {
    return auth.googleAuth().then((value) {
      if (value != null) {
        final snackBar = SnackBar(
          content: const Text("Google Sign-In Successful"),
          action: SnackBarAction(
            label: "OK", 
            onPressed: () {
              // code to undo the change
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }).catchError((err) => print(err));
  }

  Future<String?>? _onLoginFacebook() {
    return auth.facebookAuth().then((value) {
      if (value != null) {
        final snackBar = SnackBar(
          content: const Text("Facebook Sign-In Successful"),
          action: SnackBarAction(
            label: "OK", 
            onPressed: () {
              // code to undo the change
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }).catchError((err) => print(err));
  }
}