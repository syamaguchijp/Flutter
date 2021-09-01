import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

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
      home: MyWebView(),
    );
  }
}

class MyWebView extends StatefulWidget { // setStateを使う必要があるため、StatefulWidget

  MyWebView({Key? key}) : super(key: key);

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {

  WebViewController? _webViewController;
  bool _canGoBack = false;
  bool _canGoForward = false;
  int _position = 1;
  bool _isLoading = false;
  String _urlstring = _urlList[0];
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
      _urlstring = _urlList[index];
      print("_urlstring $_urlstring");
      _webViewController?.loadUrl(_urlstring);
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(_urlstring),
      ),

      body: _buildBody(),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Yahoo'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Apple'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Google'),
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

    return Column(
      children: [

        if (_isLoading) const LinearProgressIndicator(),

        Expanded( // Columnの子Widget間の隙間を目一杯埋める
          child: IndexedStack( // 複数のwidgetの表示を切り替える場合、IndexedStackを使う
            index: _position,
            children: [
              _buildWebView(),
              Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWebView() {

    return WebView(
      initialUrl: _urlstring,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onPageStarted: (String url) {
        setState(() {
          _isLoading = true;
          _position = 1;
        });
      },
      onPageFinished: (String url) async {
        if (_webViewController != null) {
          _canGoBack = await _webViewController!.canGoBack();
          _canGoForward = await _webViewController!.canGoForward();
        }
        setState(() {
          _isLoading = false;
          _position = 0;
        });
      },
      onWebResourceError: (error) {
        print("onWebResourceError : $error");
      },
    );
  }
}
