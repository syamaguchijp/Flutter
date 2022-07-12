import 'package:flutter/material.dart';
import 'package:listview/row_data.dart';
import 'network_manager.dart';

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
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: rowDataList.length,
                itemBuilder: (context, index) {
                  return _buildListRow(rowDataList[index], index);
                });
          },
        )
    );
  }

  Widget _buildListRow(RowData rowData, int index) {

    return Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black26),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          leading: Image.network(rowData.user.profileImageUrl),
          title: Text(rowData.title),
          //subtitle: Text('$index'),
          onTap: () {
            print("onTap $index");},
        ));
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
