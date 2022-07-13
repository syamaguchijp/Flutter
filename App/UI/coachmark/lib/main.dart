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

  final widgetKey = GlobalKey();
  int _counter = 0;
  bool _visible = false;
  double _bubbleX = 0.0;
  double _bubbleY = 0.0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {

    super.initState();
    // 描画が終わらないと、コーチマークの位置を決めることができないため、遅延処理する
    Future.delayed(Duration(seconds: 1))
        .then((_) => showCoachMark());
  }

  @override
  Widget build(BuildContext context) {

    var bubble = GestureDetector(
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
            child: Text('吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。吾輩は猫である。',
                textAlign: TextAlign.center,
                maxLines: 10,
                style: TextStyle(fontSize: 16.0)),
          ),
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      Stack(
        fit: StackFit.expand, // 画面いっぱい描画
        children: [
          Center(
            child: Text(
              key: widgetKey, // 座標を取得したいWidgetにkeyをつけ、参照する
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Positioned(
            // 他のオブジェクトの位置にあわせて、グローバル座標で配置する
            top: _bubbleY,
            left: _bubbleX,
            width: MediaQuery.of(context).size.width, // heightは決めなくてもsizeToFitになってくれるようだ
            child: bubble
          ),
          /*
          Align(
            // 縦横 -1 ~ 1 の範囲で自由に表示場所を指定できる
            // Alignment(横軸で表示させたい場所を -1 ~ 1 の範囲で指定 , 縦軸で表示させたい場所を -1 ~ 1 の範囲で指定)
            // -1 ~ 1 を越えた値を指定するとstackの描画範囲を超えて表示させることも可能
            // https://zenn.dev/pressedkonbu/articles/stack-and-align
              alignment: const Alignment(0, 0.2),
              child: bubble
          )*/
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void showCoachMark() {

    final RenderBox renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    print('Size: ${size.width}, ${size.height}');
    print('Offset: ${offset.dx}, ${offset.dy}');
    print('Position: ${(offset.dx + size.width) / 2}, ${(offset.dy + size.height) / 2}');
    setState(() {
      _bubbleX = 0.0;
      _bubbleY = offset.dy;
      _visible = true;
    });
  }
}
