import 'package:flutter_triple/flutter_triple.dart';

// ignore: must_be_immutable
class HomeController extends NotifierStore<Exception, int> {
  HomeController() : super(0);

  int value = 0;

  void increment() {
    value++;
    update(value);
  }
}
