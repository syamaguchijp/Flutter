import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {

  final String name;
  SecondPage(this.name){
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
        actions: <Widget> [Icon(Icons.add), Icon(Icons.share)],
      ),
      body: Container(
        color: Colors.amberAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}