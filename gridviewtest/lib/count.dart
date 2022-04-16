
import 'package:flutter/cupertino.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  int getCount() => _count;

  void increamentCount() {
    _count++;
    notifyListeners();
  }

  void unincreamentCount() {
    _count--;
    if(_count < 0) _count = 0;
    notifyListeners();
  }
}