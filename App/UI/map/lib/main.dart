import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'logging.dart';
import 'dart:math';

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

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};
  Set<Polyline> _lines = {};
  List<LatLng> _points = [];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(35.729181721661, 139.71009989122572),  // ikebukuro
    zoom: 15.0,
  );

  @override
  void initState() {

    Logging.d("");
    super.initState();

    startLocationUpdate();

    /*
    _getCurrentLocation().then((currentLocation) {
      updateMap(currentLocation);
    });
     */
  }

  @override
  Widget build(BuildContext context) {

    Logging.d("");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _markers,
        polylines: _lines,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  // 位置情報のモニタリングを行う
  void startLocationUpdate() {

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
            (Position? position) {
          if (position != null) {
            updateMap(position);
          }
        });
  }

  // 単発で位置情報を取得する
  Future<Position> _getCurrentLocation() async {

    Logging.d("");

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // マップの中心座標を移動する
  Future<void> _moveToCurrent(Position pt) async {

    Logging.d("");
    CameraPosition _current = CameraPosition(
      target: LatLng(pt.latitude, pt.longitude),
      zoom: 15.0,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_current));
  }

  // 線などを描画する
  void updateMap(currentLocation) {

    Logging.d("");
    Logging.writeLocation(currentLocation).then((value){
      Logging.readLocation().then((ary){
        _points = [];
        ary.forEach((latlon) {
          _points.add(latlon);
        });
        setState((){
          _lines = {Polyline(
            polylineId: PolylineId(Random().nextInt(100).toString()),
            points: _points,
            color: Colors.purple,
            width: 1,
          )};
          _markers = {
            Marker(
              markerId: MarkerId(Random().nextInt(100).toString()),
              position: LatLng(currentLocation.latitude, currentLocation.longitude),
              infoWindow: InfoWindow(title: "現在地"),
            ),
          };
        });
      });
    });
    _moveToCurrent(currentLocation);
  }

}
