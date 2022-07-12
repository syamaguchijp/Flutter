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

// WidgetsBindingObserverを利用するとAppLifecycleStateの状態が取得できる。
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  late AppLifecycleState _state;

  // StatefulWidgetのライフサイクル = created状態
  @override
  void initState() {
    print("created");
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // StatefulWidgetのライフサイクル = initialized状態
  @override
  void didChangeDependencies() {
    print("initialized");
    super.didChangeDependencies();
  }

  // StatefulWidgetのライフサイクル = ready状態
  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    print("ready");
    super.didUpdateWidget(oldWidget);
  }

  // StatefulWidgetのライフサイクル = defunct状態
  @override
  void dispose() {
    print("defunct");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // アプリ全体のライフサイクル
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    /*
    You can dump like below.
    state = AppLifecycleState.inactive
    state = AppLifecycleState.paused
    state = AppLifecycleState.inactive
    state = AppLifecycleState.resumed
     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
