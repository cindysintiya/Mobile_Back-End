import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  Locale locale = const Locale("id", "ID");

  changeLocale(Locale newLocale) {
    locale = newLocale;
    notifyListeners();
  }
}