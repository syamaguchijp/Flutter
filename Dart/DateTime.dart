
void main() {

  // 生成
  DateTime dt = DateTime(2021, 08, 09, 01, 02, 03);
  print(dt);
  dt = DateTime.now();
  print(dt);

  // アクセス
  print(dt.year);
  print(dt.month);
  print(dt.day);
  print(dt.hour);
  print(dt.minute);
  print(dt.second);
  print(dt.millisecond);
  print(dt.millisecondsSinceEpoch);
  print(dt.weekday); // 曜日

  // 加減
  dt = dt.add(Duration(days: 1));
  print(dt);
  DateTime dt2 = dt.add(Duration(hours: -1));
  print(dt2);
  print(dt.difference(dt2).inHours); 
  print(dt.difference(dt2)); 

  // 文字列変換
  //print(DateFormat('yyyy年M月d日').format(dt)); 

}