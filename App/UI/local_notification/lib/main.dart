import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  runApp(const MyApp());
  setup();
}

Future<void> setup() async {

  tz.initializeTimeZones();
  var tokyo = tz.getLocation('Asia/Tokyo');
  tz.setLocalLocation(tokyo);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
            const Text(
              'ローカル通知サンプル',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendLocalNotification("テスト配信", "吾輩は猫である。名前はまだ無い。吾輩は猫である。名前はまだ無い。吾輩は猫である。名前はまだ無い。"),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // ローカル通知を発信する
  Future<void> sendLocalNotification(String title, String message) async {

    final flnp = FlutterLocalNotificationsPlugin();
    flnp.initialize(
      InitializationSettings(
          android:  AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: IOSInitializationSettings()),
    ).then((_) => flnp.zonedSchedule(
        (new Random()).nextInt(10), // id
        title,
        message,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), // 5秒後
        NotificationDetails(
            android: AndroidNotificationDetails('my_channel_id', 'my_channel_name',
                importance: Importance.max, priority: Priority.high),
            iOS: IOSNotificationDetails()),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime)
    );
  }
}
