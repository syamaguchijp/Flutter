import 'package:flutter/material.dart';

import 'db_manager.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    testDB();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
    );
  }

  void testDB() async {

    DBManager dm = DBManager();

    var user = User(
      name: 'Steve',
      birthday: "2020/08/01",
    );
    await dm.insert(user);

    dm.fetchUsers().then((List<User> users) {
      for (var user in users) {
        print("${user.id} ${user.name} ${user.birthday}");
        //dm.update(user, "Bob", user.birthday);
        //dm.delete(user);
      }
    });
  }
}
