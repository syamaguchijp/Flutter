import 'package:intl/intl.dart';

class User {
  int? id; // primary autoincrement
  final String name;
  final String birthday;

  User({this.id, required this.name, required this.birthday});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthday': birthday,
    };
  }
}