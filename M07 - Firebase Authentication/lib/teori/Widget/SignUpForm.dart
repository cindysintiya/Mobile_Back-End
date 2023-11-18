import 'package:flutter/material.dart';
import 'package:case_study_latihan/teori/Helper/authentication.dart';
import 'package:case_study_latihan/teori/home.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? name;

  bool _obscureText = false;

  bool agree = false;
  final pass = TextEditingController();

  late AuthenticationHelper auth;

  @override
  void initState() {
    super.initState();
    auth = AuthenticationHelper();
  }

  @override
  Widget build(BuildContext context) {
    var border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(100.0),
      ),
    );

    var space = const SizedBox(height: 10);
    return Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    labelText: 'Email',
                    border: border),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (val) {
                  email = val;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              space,
              TextFormField(
                controller: pass,
                obscureText: !_obscureText,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: border,
                  suffixIcon: GestureDetector(
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                onSaved: (val) {
                  password = val;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 6) {
                    return "Password too short";
                  }
                  return null;
                },
              ),
              space,
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: border,
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please re-enter your password";
                  } else if (value != pass.text) {
                    return "Password not match";
                  } else if (value.length < 6) {
                    return "Password to short";
                  }
                  return null;
                },
              ),
              space,
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: const Icon(Icons.account_circle),
                  border: border,
                ),
                onSaved: (val) {
                  name = val;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your fullname";
                  }
                  return null;
                },
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = !agree;
                      });
                    },
                  ),
                  const Flexible(
                    child: Text(
                        "By creating account, I agree to terms & conditions and privacy policy."),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        auth.signUp(email: email!, password: password!);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)))),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20),
                    ),
                  ) //endchild
                  ),
            ]));
  }
}
