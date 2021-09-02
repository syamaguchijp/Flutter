import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              showPageView();
            }, child: Text("showPageView")),
            Padding(
              padding: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }

  void showPageView() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) {
              return MyStatelessWidget();
            },
            fullscreenDialog: true));
  }
}

class MyStatelessWidget extends StatelessWidget {

  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        page1(),
        page2(),
        SecondScreen("4"),
      ],
    );
  }

  Widget page1() {
    return Center(
      child: Container(
        child: Text('1', style: TextStyle(fontSize: 30.0),),
      ),
    );
  }

  Widget page2() {
    return Center(
      child: Container(
        child: Text('2', style: TextStyle(fontSize: 30.0),),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String name;
  SecondScreen(this.name){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SecondScreen")),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(name),
                ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen("2")),
                  );
                }, child: Text("モーダル")),
              ]
          )
      ),
    );
  }
}
