import 'package:flutter/widgets.dart';

@immutable
class MyUser {

  String name;
  String url;
  String result;

  MyUser({this.name = "", this.url = "", this.result = ""}) {
  }
}