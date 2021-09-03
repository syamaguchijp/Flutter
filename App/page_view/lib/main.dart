import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              showPageView();
            }, child: Text("showPageView")),
            Padding(
              padding: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }

  void showPageView() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) {
              return MyPageViewWidget();
            },
            fullscreenDialog: true));
  }
}

class MyPageViewWidget extends StatefulWidget {
  MyPageViewWidget({Key? key}) : super(key: key);
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageViewWidget> {

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return Column(
        children: [
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: <Widget>[
                page1(),
                page2(),
                SecondScreen("3"),
              ],
            ),
            //flex: 9,
          ),
          Container(
            alignment: Alignment.center,
            height: 100.0,
            child: new PageIndicator(
              layout: PageIndicatorLayout.NONE,
              size: 20.0,
              activeSize: 30.0,
              controller: controller,
              space: 5.0,
              count: 3,
            ),
          ),
        ]
    );
  }

  Widget page1() {
    return Center(
      child: Container(
        child: Text('1', style: TextStyle(fontSize: 30.0),),
      ),
    );
  }

  Widget page2() {
    return Center(
      child: Container(
        child: Text('2', style: TextStyle(fontSize: 30.0),),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String name;
  SecondScreen(this.name){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SecondScreen")),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(name),
                ElevatedButton(onPressed: (){
                  // モーダルを閉じる
                  Navigator.of(context).pop();
                }, child: Text("完了")),
              ]
          )
      ),
    );
  }
}
