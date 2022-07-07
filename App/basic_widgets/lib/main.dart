import 'package:flutter/material.dart';
import 'next_page.dart';

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

  int _counter = 0;
  String inputStr = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void pushToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NextPage("Yama")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget> [Icon(Icons.add), Icon(Icons.share)],
      ),

      body: SingleChildScrollView (
      //body: Container(
        //color: Colors.black12,
        //width: double.infinity,

        child: Center(

          child: Column( // 上から下に並んでいく。ColumnじゃなくてRowにすると、左から右に並ぶ。

            mainAxisAlignment: MainAxisAlignment.start, // 横
            crossAxisAlignment: CrossAxisAlignment.center, // 縦

            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(20),
              ),

              TextFormField( // 複数のTextformFieldがある場合は、Formでくるむ
                // https://flutter.dev/docs/cookbook/forms/validation
                // 未完成
                validator: (value) {
                  if (value == null ||value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "input some word."
                ),
                onChanged: (text) {
                  print("$text");
                  setState(() {
                    inputStr = text;
                  });
                }
              ),

              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      inputStr,
                    ),
                    Text(
                      '$_counter',
                    ),
                  ]
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
              ),

              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),

              ElevatedButton(onPressed: (){
                pushToNextScreen();
              }, child: Text("画面遷移")),

              Padding(
                padding: EdgeInsets.all(20),
              ),

              Image.asset('images/kenmeri.jpg',
                  width: double.infinity),

              Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),

              Image.asset('images/kenmeri.jpg',
                  width: double.infinity),

            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
