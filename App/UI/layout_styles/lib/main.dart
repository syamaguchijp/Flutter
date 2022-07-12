import 'package:flutter/material.dart';

import 'styles.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildColumn(),
    );
  }

  Widget _buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {},
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 100,
                color: Colors.red,
                child: Text('Expanded flex1',
                    style: Styles.textStyleNormal),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 100,
                color: Colors.yellow,
                child: Text('Expanded flex2',
                    style: Styles.textStyleTitle),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.black26
                  )
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Padding( // Containerにもpaddingやmargin属性があるのであえてこれを使う必要はないかも。
              padding: EdgeInsets.all(10.0),
              child: Container(
                color: Colors.purple,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 30,
                    width: 50,
                    color: Colors.red,
                  )
                )
              )
          )
        ),

        Expanded(
          child: Container(
            color: Colors.green,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  color: Colors.deepOrange,
                  height: 300.0,
                  width: 300.0,
                ),
                Container(
                  color: Colors.orange,
                  height: 200.0,
                  width: 200.0,
                ),
                Positioned(
                  top: 50.0,
                  right: 10.0,
                  child: Container(
                    color: Colors.limeAccent,
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 20.0,
                  child: Container(
                    color: Colors.yellow,
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                // 最後の要素が一番最前面にくる
              ],
            ),
          ),
          flex: 9,
        ),

        Expanded(
          child: Container(
            color: Colors.pink,
          ),
          flex: 1,
        ),
      ],
    );
  }

}
