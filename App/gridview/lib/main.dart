import 'package:flutter/material.dart';
import 'package:gridview/network_manager.dart';

import 'row_data.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {

    List<RowData> rowDataList = <RowData>[];
    NetworkManager networkManager = NetworkManager();

    return RefreshIndicator(
        onRefresh: () async {
          rowDataList = await networkManager.fetchQiitaApi();
        },
        child: FutureBuilder(
          initialData: <RowData>[],
          future: networkManager.fetchQiitaApi(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.none && !snapshot.hasData) {
              return Text('No data');
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return loader();
            }

            rowDataList = snapshot.data;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: rowDataList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildListRow(rowDataList[index], index);
              }
            );
          },
        )
    );
  }

  Widget _buildListRow(RowData rowData, int index) {

    return GestureDetector(
      child: GridTile(
        child: Image.network(rowData.user.profileImageUrl),
        footer: Center(
          child: Text(rowData.title),
        )
      ),
      onTap: () {
        print("onTap $index");
      },
    );
  }

  Widget loader() {

    return Center(
      child: SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

