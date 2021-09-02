import 'package:drawer/second_page.dart';
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      /* // 画面遷移はしないのでコメントアウト
      routes: <String, WidgetBuilder>{
        '/yahoo': (BuildContext context) => MyWebView(urlstring: "https://yahoo.co.jp"),
        '/apple': (BuildContext context) => MyWebView(urlstring: "https://apple.com"),
        '/google': (BuildContext context) => MyWebView(urlstring: "https://google.com"),
      },
       */
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

  MyWebView myWebView = MyWebView(urlstring: "https://yahoo.co.jp");
  Widget? bodyWidget;

  @override
  void initState() {
    super.initState();
    bodyWidget = myWebView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('ヘッダー'),
              decoration: BoxDecoration(
              color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("Yahoo"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                setState((){
                  if (bodyWidget is MyWebView == false) {
                    myWebView = MyWebView(urlstring: "https://yahoo.co.jp");
                  }
                  bodyWidget = myWebView;
                  myWebView.loadUrl("https://yahoo.co.jp");
                });
                //Navigator.pushNamed(context, '/yahoo'); // これだと画面遷移になってしまう
              },
            ),
            ListTile(
              title: Text("Apple"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                setState((){
                  if (bodyWidget is MyWebView == false) {
                    myWebView = MyWebView(urlstring: "https://apple.com");
                  }
                  bodyWidget = myWebView;
                  myWebView.loadUrl("https://apple.com");
                });
                //Navigator.pushNamed(context, '/apple'); // これだと画面遷移になってしまう
              },
            ),
            ListTile(
              title: Text("SecondPage"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                setState((){
                  bodyWidget = SecondPage("test");
                });
              },
            ),
          ],
        ),
      ),
      body: bodyWidget//MyWebView(urlstring: "https://yahoo.co.jp"),
    );
  }
}
