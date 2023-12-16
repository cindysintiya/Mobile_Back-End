import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:case_study_latihan/my_provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MyProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Semantic")),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Aplikasi Semantics buatan Anak Negeri"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Name".i18n(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.help_rounded,
                    semanticLabel: "Bantuan",   // cocok utk listtile sekaligus, bkn dibaca per item dlm listtile
                  ),
                  title: Text("Text_call".i18n(), style: const TextStyle(color: Colors.blue),),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.help_rounded,
                  ),
                  title: const Text("cindy@sintiya.com", style: TextStyle(color: Colors.blue),),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _isChecked, 
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  }
                ),
                Text("Checkbox-agree".i18n())
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () { },
                    child: Text("Button-sign-in".i18n())
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () { },
                    child: Text("Button-sign-out".i18n())
                  ),
                ),
              ],
            ),
          ),

          // button utk ganti bahasa
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: prov.locale == const Locale('id', 'ID')? null : () {
                      prov.changeLocale(const Locale('id', 'ID'));
                      showDialog(
                        context: context, 
                        barrierDismissible: false,
                        builder: (context) {
                          return const AlertDialog(
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 30),
                                CircularProgressIndicator(),
                                SizedBox(height: 10),
                                Text("Loading"),
                              ],
                            ),
                          );
                        }
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        prov.changeLocale(const Locale('id', 'ID'));
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("B. Indonesia")
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: prov.locale == const Locale('en', 'US')? null : () {
                      prov.changeLocale(const Locale('en', 'US'));
                      showDialog(
                        context: context, 
                        barrierDismissible: false,
                        builder: (context) {
                          return const AlertDialog(
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 30),
                                CircularProgressIndicator(),
                                SizedBox(height: 10),
                                Text("Loading"),
                              ],
                            ),
                          );
                        }
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        prov.changeLocale(const Locale('en', 'US'));
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("B. Inggris")
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: prov.locale == const Locale('es', 'ES')? null : () {
                      prov.changeLocale(const Locale('es', 'ES'));
                      showDialog(
                        context: context, 
                        barrierDismissible: false,
                        builder: (context) {
                          return const AlertDialog(
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 30),
                                CircularProgressIndicator(),
                                SizedBox(height: 10),
                                Text("Loading"),
                              ],
                            ),
                          );
                        }
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        prov.changeLocale(const Locale('es', 'ES'));
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("B. Spanyol")
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: prov.locale == const Locale('it', 'IT')? null : () {
                      prov.changeLocale(const Locale('it', 'IT'));
                      showDialog(
                        context: context, 
                        barrierDismissible: false,
                        builder: (context) {
                          return const AlertDialog(
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 30),
                                CircularProgressIndicator(),
                                SizedBox(height: 10),
                                Text("Loading"),
                              ],
                            ),
                          );
                        }
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        prov.changeLocale(const Locale('it', 'IT'));
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("B. Italia")
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}