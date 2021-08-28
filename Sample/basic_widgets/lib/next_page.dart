import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {

  final String name;
  NextPage(this.name){
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Second Page"),
        actions: <Widget> [Icon(Icons.add), Icon(Icons.share)],
      ),

      body: Container(
        color: Colors.amberAccent,

        child: Center(
          //body: Padding(
          //padding: const EdgeInsets.all(16.0),

          child: Column( // 上から下に並んでいく。ColumnじゃなくてRowにすると、左から右に並ぶ。

            mainAxisAlignment: MainAxisAlignment.start,//MainAxisAlignment.center,

            children: <Widget>[
              Text(
                name,
              ),

              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("戻る"))
            ],
          ),
        ),
      ),
    );
  }
}