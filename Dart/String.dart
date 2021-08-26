
void main(){

  String str = "アイウエオ";
  print(str);

  // ヒアドキュメント
  str = """
あいう
えお""";
  print(str);

  // 文字列内の変数利用
  str = "アイウエオ";
  print("$str");
  print("${str}");

  // 一致判定
  print(str == "アイウエオ");
  print(str.contains("イウエ"));
  print(str.startsWith("アイ"));
  print(str.endsWith("エオ"));

  // 長さ
  print(str.length);

  // 切り出し
  print(str.substring(2)); // ウエオ
  print(str.substring(1,3)); // イウ

  // 分割
  str = "Honda,Yamaha,Kawasaki";
  List<String> ary = str.split(",");
  print(ary);

  // 置換
  str = str.replaceAll("Kawasaki", "Suzuki");
  print(str);

  // 前後の空白を削除
  str = " ABC DE FG \n";
  str = str.trimRight();
  print(str);
  str = str.trimLeft();
  print(str);
  str = " ABC DE FG \n";
  str = str.trim(); // 両端
  print(str);

  // 大文字小文字
  str = "abcde";
  str = str.toUpperCase();
  print(str);
  str = str.toLowerCase();
  print(str);

  // 数値
  str = "100";
  print(int.parse(str));
  int num = 1000;
  print(num.toString());

}
