import 'package:flutter/material.dart';
import 'my_webview.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  TabController? _tabController;
  final _tab = <Tab> [
    Tab( text:'Yahoo', icon: Icon(Icons.directions_car)),
    Tab( text:'Apple', icon: Icon(Icons.directions_bike)),
    Tab( text:'Google', icon: Icon(Icons.directions_boat)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tab.length);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(widget.title),
        toolbarHeight: 0.0,
        bottom: TabBar(
          controller: _tabController,
          tabs: _tab,
        ),
      ),
      body: TabBarView(
          physics: NeverScrollableScrollPhysics(), // これを設定すると、WebView内でのスクロールは可能となるが、横スクロールでのタブの切り替えはできなくなる。
          controller: _tabController,
          children: <Widget> [
            MyWebView(urlstring: "https://yahoo.co.jp"),
            MyWebView(urlstring: "https://apple.com"),
            MyWebView(urlstring: "https://google.com"),
          ]
      ),
    );
  }
}
