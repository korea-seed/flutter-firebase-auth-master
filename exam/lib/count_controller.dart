//import 'package:get/get.dart';

//class CountController extends GetxController {
//class CountController {
class Singleton {
  int count = 0;

  static final Singleton _instance = Singleton._internal();

  factory Singleton() {
    return _instance;
  }

  Singleton._internal() {
    count = 0;
    print('Singleton was created');
  }
/*
  int get count => _count;

  void increment() {
    _count++;
    print('countcontroll = $_count');
    update();
  }

  void decrease() {
    _count--;
    if (_count <= 0) {
      print('countcontroll = $_count');
      _count = 0;
    }
    update();
  }
 */
}
