import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

class MyHomePage extends StatefulWidget { // setStateを使う必要があるため、StatefulWidget

  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  WebViewController? _webViewController;
  bool _canGoBack = false;
  bool _canGoForward = false;
  int _position = 1;
  bool _isLoading = false;
  String _title = '';

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
        title: Text(_title),
      ),

      body: _buildBody(),

      persistentFooterButtons: [
        IconButton(
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
      initialUrl: 'https://yahoo.co.jp',
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
        final title = await _webViewController!.getTitle();
        setState(() {
          if (title != null) {
            _title = title;
          }
        });
      },
      onWebResourceError: (error) {
        print("onWebResourceError : $error");
      },
    );
  }

}
