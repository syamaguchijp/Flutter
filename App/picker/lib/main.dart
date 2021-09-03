import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_picker/flutter_picker.dart';

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

  String _showTimePickerText = "";
  String _dateTimePickerText = "";
  String _datePickerText = "";
  String _listPickerText = "";

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

            //////// showTimePicker

            Text(_showTimePickerText),
            ElevatedButton(onPressed: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );
              if (selectedTime != null) {
                var dt = _toDateTime(selectedTime);
                setState(() {
                  _showTimePickerText = (DateFormat.Hm()).format(dt);
                });
              }
            }, child: Text("showTimePicker")),
            Padding(
              padding: EdgeInsets.all(20),
            ),

            //////// FlutterPicker（DateTime）

            Text(_dateTimePickerText),
            ElevatedButton(onPressed: () async {
              Picker(
                  adapter: DateTimePickerAdapter(
                    type: PickerDateTimeType.kMDYHM,
                    isNumberMonth: true,
                    yearSuffix: "年",
                    monthSuffix: "月",
                    daySuffix: "日",
                    hourSuffix: "時",
                    minuteSuffix: "分",
                    secondSuffix: "秒",
                    minValue: DateTime.now(),
                    minuteInterval: 10,
                  ),
                  title: Text("Select DateTime"),
                  textAlign: TextAlign.right,
                  selectedTextStyle: TextStyle(color: Colors.blue),
                  delimiter: [
                    PickerDelimiter(column: 5, child: Container(
                      width: 16.0,
                      alignment: Alignment.center,
                      child: Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
                      color: Colors.white,
                    ))
                  ],
                  footer: Container(
                    height: 60.0,
                    alignment: Alignment.center,
                    child: Text('Footer'),
                  ),
                  onSelect: (Picker picker, int index, List<int> selected) {
                    setState(() {
                      _dateTimePickerText = picker.adapter.toString();
                    });
                  },
                  onConfirm: (Picker picker, List value) {
                    print(picker.adapter.text);
                  },
                  onCancel: () {
                    setState(() {
                      _dateTimePickerText = "";
                    });
                  }
              ).showModal(context);

            }, child: Text("DateTimePicker")),
            Padding(
              padding: EdgeInsets.all(20),
            ),

            //////// FlutterPicker（Time）

            Text(_datePickerText),
            ElevatedButton(onPressed: () async {
              Picker(
                  hideHeader: true,
                  adapter: DateTimePickerAdapter(),
                  title: Text("Select Date"),
                  selectedTextStyle: TextStyle(color: Colors.blue),
                  onConfirm: (Picker picker, List value) {
                    print((picker.adapter as DateTimePickerAdapter).value);
                    setState(() {
                      _datePickerText = (DateFormat('yyyy/MM/dd')).format(
                          (picker.adapter as DateTimePickerAdapter).value!
                      );
                    });
                  },
                  onCancel: () {
                    setState(() {
                      _datePickerText = "";
                    });
                  }
              ).showDialog(context);

            }, child: Text("DatePicker")),
            Padding(
              padding: EdgeInsets.all(20),
            ),

            //////// FlutterPicker（List）

            Text(_listPickerText),
            ElevatedButton(onPressed: () async {
              Picker(
                  adapter: PickerDataAdapter<String>(pickerdata: list, isArray: false),
                  hideHeader: true,
                  title: new Text("Please Select below"),
                  onConfirm: (Picker picker, List value) {
                    print(value.toString());
                    print(picker.getSelectedValues());
                    setState(() {
                      _listPickerText = picker.getSelectedValues()[0];
                    });
                  },
                  onCancel: () {
                    setState(() {
                      _listPickerText = "";
                    });
                  }
              ).showDialog(context);
            }, child: Text("ListPicker")),
            Padding(
              padding: EdgeInsets.all(20),
            ),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<String> list = ["Honda", "Yamaha", "Kawasaki", "Suzuki"];

  DateTime _toDateTime(TimeOfDay t) {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day,
        t.hour, t.minute);
  }
}
