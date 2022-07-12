import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

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
  int _counter = 0;
  bool _visible = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand, // 画面いっぱい描画
          children: [
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Align(
              // 縦横 -1 ~ 1 の範囲で自由に表示場所を指定できる
              // Alignment(横軸で表示させたい場所を -1 ~ 1 の範囲で指定 , 縦軸で表示させたい場所を -1 ~ 1 の範囲で指定)
              // -1 ~ 1 を越えた値を指定するとstackの描画範囲を超えて表示させることも可能
              // https://zenn.dev/pressedkonbu/articles/stack-and-align
              alignment: const Alignment(-0.9, -0.9),
              child:
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _visible = false;
                    });
                  },
                  child: Visibility(
                    visible: _visible,
                    child: Bubble(
                      margin: BubbleEdges.only(top: 10),
                      padding: BubbleEdges.all(15),
                      nipWidth: 8,
                      nipHeight: 24,
                      nip: BubbleNip.leftTop,
                      color: Color.fromRGBO(225, 255, 199, 1.0),
                      child: Text('吾輩は猫である。吾輩は猫である。吾輩は猫である。', textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0)),
                    ),
                  )
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
