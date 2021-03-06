import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'allow_vertical_draggesture_recognizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget { // setStateを使う必要があるため、StatefulWidget

  MyWebView({Key? key, required this.urlstring}) : super(key: key);
  String urlstring;

  _MyWebViewState myWebviewState = _MyWebViewState();

  @override
  _MyWebViewState createState() {
    return myWebviewState;
  }

  void loadUrl(String s) {
    urlstring = s;
    myWebviewState.loadUrl(s);
  }
}

class _MyWebViewState extends State<MyWebView> {

  WebViewController? _webViewController;
  bool _canGoBack = false;
  bool _canGoForward = false;
  int _position = 1;
  bool _buttonRowVisible = true;
  bool _isLoading = false;
  String _urlstring = '';

  @override
  void initState() {

    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {

    _urlstring = widget.urlstring;
    return Scaffold(
      appBar: AppBar(
        title: Text(_urlstring),
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
            index: _position, // WebViewのZ座標の位置
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _buildWebView(),
                  Container(
                    color: Colors.white,
                    child: Visibility(
                      visible: _buttonRowVisible,
                      // maintainSize: true,
                      child: _buildButtonsRow(),
                    ))
                ],
              ),
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

  Widget _buildButtonsRow() {

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
        ]);
  }

  Widget _buildWebView() {

    return WebView(
      initialUrl: _urlstring,
      gestureNavigationEnabled: true,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onPageStarted: (String url) {
        setState(() {
          _isLoading = true;
          _position = 1; // CircularProgressIndicatorを前面にもってきて表示させる
        });
      },
      onPageFinished: (String url) async {
        if (_webViewController != null) {
          _canGoBack = await _webViewController!.canGoBack();
          _canGoForward = await _webViewController!.canGoForward();
        }
        setState(() {
          _isLoading = false;
          _position = 0; // CircularProgressIndicatorより前面に出て表示を終了する
        });
      },
      onWebResourceError: (error) {
        print("onWebResourceError : $error");
      },
        gestureRecognizers: Set()
          ..add(
            Factory<AllowVerticalDragGestureRecognizer>(
                    () => AllowVerticalDragGestureRecognizer()
                  ..onStart = (DragStartDetails details) {
                    print("Drag start");
                  }
                  ..onUpdate = (DragUpdateDetails details) {
                    print("Drag update: ${details.delta.dy}");
                    if (details.delta.dy < 0) {
                      // ドラッグして下を見ようとしているため、ツールバーを非表示にする
                      setState(() {
                        _buttonRowVisible = false;
                      });
                      //_position = 1;
                      print("Drag _buttonRowVisible false");
                    } else {
                      setState(() {
                        _buttonRowVisible = true;
                      });
                      print("Drag _buttonRowVisible true");
                    }
                  }
                  ..onDown = (DragDownDetails details) {
                    print("Drag down: $details");
                  }
                  ..onCancel = () {
                    print("Drag cancel");
                  }
                  ..onEnd = (DragEndDetails details) {
                    print("Drag end");
                  }
            ),
          ),
        /*
        // これだと、onDownとonCancelしかコールされない
        // https://github.com/flutter/flutter/issues/39389
          ..add(Factory<VerticalDragGestureRecognizer>(() {
            return VerticalDragGestureRecognizer()
              ..onStart = (DragStartDetails details) {
                print("Drag start");
              }
              ..onUpdate = (DragUpdateDetails details) {
                print("Drag update: $details");
              }
              ..onDown = (DragDownDetails details) {
                print("Drag down: $details");
              }
              ..onCancel = () {
                print("Drag cacel");
              }
              ..onEnd = (DragEndDetails details) {
                print("Drag end");
              };
          }))
         */
    );
  }

  void loadUrl(String s) {

    print("loadUrl $s");
    _webViewController?.loadUrl(s);
  }
}

