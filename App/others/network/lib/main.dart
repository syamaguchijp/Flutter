import 'package:flutter/material.dart';
import 'package:network/row_data.dart';
import 'network_manager.dart';

// https://flutter.dev/docs/cookbook/networking/fetch-data

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

  late Future<List<RowData>> futureRowDatas;

  @override
  void initState() {
    super.initState();
    NetworkManager networkManager = NetworkManager();
    futureRowDatas = networkManager.fetchQiitaApi();
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
            FutureBuilder<List<RowData>>(
              future: futureRowDatas,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data![0].title);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
