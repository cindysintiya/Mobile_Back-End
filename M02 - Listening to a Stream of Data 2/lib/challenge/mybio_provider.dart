import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBioProvider extends ChangeNotifier {
  String? image;
  double score = 0;
  final ImagePicker picker = ImagePicker();
  String date = DateTime.now().toString();

  final String _keyScore = 'score';
  final String _keyImage = 'image';
  final String _keyDate = 'date';
  late SharedPreferences prefs;

  late StreamController<int> streamCtrl = StreamController<int>();

  void loadData() async {
    prefs = await SharedPreferences.getInstance();
    score = prefs.getDouble(_keyScore) ?? 0;
    image = prefs.getString(_keyImage);
    date = prefs.getString(_keyDate) ?? DateTime.now().toString();
    notifyListeners();
  }

  Future<void> setScore(double value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(_keyScore, value);
    score = prefs.getDouble(_keyScore) ?? 0;
    notifyListeners();
  }

  Future<void> setImage(String? value) async {
    prefs = await SharedPreferences.getInstance();
    if (value != null) {
      prefs.setString(_keyImage, value);
      image = prefs.getString(_keyImage);
      notifyListeners();
    }
  }

  Future<void> setDate(String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyDate, value);
    date = prefs.getString(_keyDate) ?? DateTime.now().toString();
    notifyListeners();
  }
}