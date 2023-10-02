import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:case_study_latihan/shopping_list.dart';
import 'package:case_study_latihan/history_list.dart';

class ListProductProvider extends ChangeNotifier {
  List<ShoppingList> _shoppingList = [];
  List<ShoppingList> get shoppingList => _shoppingList;
  set shoppingList(value) {
    _shoppingList = value;
    notifyListeners();
  }

  List<HistoryList> _historyList = [];
  List<HistoryList> get historyList => _historyList;
  set historyList(value) {
    _historyList = value;
    notifyListeners();
  }

  void deleteById(shoppingList) {
    _shoppingList.remove(shoppingList);
    notifyListeners();
  }

  void deleteAll() {
    _shoppingList.clear();
    notifyListeners();
  }

  int id = 0;
  late SharedPreferences prefs;

  void loadData() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('id') ?? 0;
    notifyListeners();
  }

  Future<void> setId(int value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', value);
    id = prefs.getInt('id') ?? 0;
    notifyListeners();
  }
}