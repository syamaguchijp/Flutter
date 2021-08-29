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

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  int position = 1;
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
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        if (_isLoading) const LinearProgressIndicator(),
        Expanded( // Columnの子Widget間の隙間を目一杯埋める
          child: IndexedStack( // 複数のwidgetの表示を切り替える場合、IndexedStackを使う
            index: position,
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
        _controller.complete;
      },
      onPageStarted: (String url) {
        setState(() {
          _isLoading = true;
          position = 1;
        });
      },
      onPageFinished: (String url) async {
        setState(() {
          _isLoading = false;
          position = 0;
        });
        final controller = await _controller.future;
        final title = await controller.getTitle();
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
