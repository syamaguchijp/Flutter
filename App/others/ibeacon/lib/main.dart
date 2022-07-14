import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

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

  String beaconUUID = "00000000-70E5-1001-B000-001C4DE8752C";

  @override
  void initState(){

    super.initState();

    flutterBeacon.initializeAndCheckScanning;//initializeScanning;
    //TODO: 許諾まわりの実装が必要

    final regions = <Region>[];
    if (Platform.isIOS) {
      //regions.add(Region(identifier: 'Apple', proximityUUID: beaconUUID));
    } else {
      regions.add(Region(identifier: 'com.beacon'));
    }

    StreamSubscription streamRanging = flutterBeacon.ranging(regions).listen((RangingResult result) {
      print("ranging ${result.toJson}");
    });
    //streamRanging.cancel();

    // doesn't seem to work
    StreamSubscription streamMonitoring = flutterBeacon.monitoring(regions).listen((MonitoringResult result) {
      if (result != null && result.region != null) {
        print('monitoringResult ${result.region.proximityUUID}');
        if (result.region.proximityUUID == beaconUUID &&
            result.monitoringState == MonitoringState.inside) {
            print("Beacon IN!");
        }
      }
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

          ],
        ),
      ),
    );
  }
}
