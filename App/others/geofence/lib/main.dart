import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  @override
  void initState() {

    super.initState();

    Geofence.initialize();
    Geofence.requestPermissions();
    //TODO: requestPermissionsがうまくいっていない。Android

    Geolocation location = Geolocation(
        latitude: 35.0,
        longitude: 139.0,
        radius: 50.0,
        id: "Home");
    Geofence.addGeolocation(location, GeolocationEvent.entry).then((onValue) {
      print("addGeolocation success.");
      Geofence.startListening(GeolocationEvent.entry, (entry) {
        sendLocalNotificationImmediate("Test", "Come into ${entry.id}");
      });
      Geofence.startListening(GeolocationEvent.exit, (entry) {
        // exitはコールされている？
        sendLocalNotificationImmediate("Test", "Get out of ${entry.id}");
      });
    }).catchError((error) {
      print("failed $error");
    });
  }

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
              "",
            ),
          ],
        ),
      ),
    );
  }

  // ローカル通知をただちに発信する
  Future<void> sendLocalNotificationImmediate(String title, String message) async {

    final flnp = FlutterLocalNotificationsPlugin();
    flnp.initialize(
      InitializationSettings(
          android:  AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: IOSInitializationSettings()),
    ).then((_) => flnp.show(0, title, message, NotificationDetails(
      android: AndroidNotificationDetails(
          'channel_id',
          'channel_name', importance: Importance.max, priority: Priority.high
      ),
    )));
  }
}
