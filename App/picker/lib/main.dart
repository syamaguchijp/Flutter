import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String _labelText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // showTimePicker
            Text(_labelText),
            ElevatedButton(onPressed: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );
              if (selectedTime != null) {
                var dt = _toDateTime(selectedTime!);
                setState(() {
                  _labelText = (DateFormat.Hm()).format(dt);
                });
              }
            }, child: Text("showTimePicker")),
            Padding(
              padding: EdgeInsets.all(20),
            ),


          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  DateTime _toDateTime(TimeOfDay t) {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day,
        t.hour, t.minute);
  }
}
