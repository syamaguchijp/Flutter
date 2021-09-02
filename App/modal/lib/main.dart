import 'package:flutter/material.dart';

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
              pushAlertDialog();
            }, child: Text("アラートダイアログ")),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            ElevatedButton(onPressed: (){
              pushModal();
            }, child: Text("モーダル")),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            ElevatedButton(onPressed: (){
              pushHalfModal();
            }, child: Text("ハーフモーダル")),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            ElevatedButton(onPressed: (){
              pushSnackbar();
            }, child: Text("スナックバー")),
            Padding(
              padding: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void pushAlertDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("アラート"),
          content: Text("今日は良いお天気ですね。外出しますか？"),
          actions: <Widget>[
            // ボタン領域
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void pushModal() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) {
              return SecondScreen("1");
            },
            fullscreenDialog: true));
        // MaterialPageRouteのfullscreenDialogをtrueにするとモーダル表示される。
  }

  void pushHalfModal() {

    showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.music_note),
              title: Text('Music'),
              onTap: () => Navigator.of(context).pop(1),
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Video'),
              onTap: () => Navigator.of(context).pop(2),
            ),
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Picture'),
              onTap: () => Navigator.of(context).pop(3),
            ),
          ],
        );
      },
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