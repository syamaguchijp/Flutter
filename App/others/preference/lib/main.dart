import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("_getPrefItems ${prefs.getString('my_name')}");
  }

  _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('my_name', "Yamada Taro");
  }

  _removePrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('my_name');
  }

  @override
  Widget build(BuildContext context) {

    _setPrefItems();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

      ),
    );
  }
}
