import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
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

class MyHomePage extends StatefulWidget { // setStateを使う必要があるため、StatefulWidget

  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  static List<String> _urlList = [
    "https://yahoo.co.jp",
    "https://apple.com",
    "https://google.com"
  ];

  // タップ時の処理
  void _onItemTapped(int index) {
    print("_onItemTapped $index");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(_urlList[_selectedIndex]),
      ),

      body: _buildBody(),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Yahoo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Apple',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Google',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      /*
      // bottomNavigationBarと相性が悪く、上にずれるため、コメントアウトしておく
      persistentFooterButtons: [
        IconButton( // if (_canGoBack) で非表示にもできる
          icon: Icon(Icons.arrow_back),
          onPressed: _canGoBack ? _webViewController?.goBack : null,
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: _canGoForward ? _webViewController?.goForward : null,
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: (){_webViewController?.reload();},
        )
      ],
      */
    );
  }

  Widget _buildBody() {

    return IndexedStack( // 複数のwidgetの表示を切り替える場合、IndexedStackを使う
      index: _selectedIndex, // 選択中のインデックス
      children: [
        MyWebView(urlstring: _urlList[0]),
        MyWebView(urlstring: _urlList[1]),
        MyWebView(urlstring: _urlList[2]),
      ],
    );
  }
}
