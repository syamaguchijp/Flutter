import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildWebView()
    );
  }

  Widget _buildWebView() {

    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) async {
        _controller = webViewController;
        await _loadHtmlFromAssets();
      },
      onPageFinished: (String url) async {
        var dataArray = [["東京", 50], ["大阪", 30], ["新潟", 10]];
        var dataStr = jsonEncode(dataArray);
        _controller.runJavascript("window.drawPieChart(${dataStr})");

        var dataArray2 = [["2018", 800, 120], ["2019", 600, 100], ["2020", 900, 150], ["2021", 500, 170]];
        var dataStr2 = jsonEncode(dataArray2);
        _controller.runJavascript("window.drawLineChart(${dataStr2})");
      },
    );
  }

  Future _loadHtmlFromAssets() async {

    String fileText = await rootBundle.loadString('assets/test.html');
    _controller.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
}
