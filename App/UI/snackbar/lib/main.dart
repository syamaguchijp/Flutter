import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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

  var _isChanged = false;

  final _key = GlobalKey();
  double height = 0;

  @override
  void initState() {

    // ウィジェットからサイズを取得する。（ビルドされたときに、高さが取得できる）
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        height = _key.currentContext!.size!.height;
        print("height = $height");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            left: _isChanged ? 0 : 0,
            top: _isChanged ? 0 : -height, // -heightではなく-3000とかにすれば最初から画面外に位置して見えずに済む。
            duration: Duration(seconds: 1),
            child:GestureDetector(
              onTap: () {
                setState(() {
                  _isChanged = !_isChanged;
                });
              },
              child: Container(
                  key: _key, // テキスト量に応じた高さを取得するためのGlobalKey
                  width: MediaQuery.of(context).size.width - 20,
                  color: Colors.blue,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text('吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。',
                      textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0))
              ),
            )
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: (){
                  pushSnackbar();
                }, child: Text("スナックバー")),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                ElevatedButton(onPressed: (){
                  setState(() {
                    _isChanged = !_isChanged;
                  });
                }, child: Text("自作アニメーション")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void pushSnackbar() {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('今日は良いお天気です。今日は良いお天気です。今日は良いお天気です。今日は良いお天気です。今日は良いお天気です。今日は良いお天気です。END'),
        backgroundColor: Colors.grey,
        duration: Duration(milliseconds: 5000),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () => print('onPressed'),
        ),
      ),
    );
  }
}
