import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveProvider with ChangeNotifier {
  isBoxOpen(String name) async {
    bool isBoxOpen = await Hive.isBoxOpen(name);
    notifyListeners();
    return isBoxOpen;
  }
}
