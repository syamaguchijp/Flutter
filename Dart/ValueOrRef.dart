
void main() {

  // 数値（値型）
  int val1 = 2;
  test1(val1);
  print("val1=$val1");

  // 文字列（値型）
  String val2 = "hoge";
  test2(val2);
  print("val2=$val2");

  // リスト（参照型）
  List<String> val3 = ["Honda", "Yamaha", "Kawasaki"];
  test3(val3);
  print("val3=$val3");

  // クラス（参照型）
  User val4 = User("hoge");
  test4(val4);
  print("val4=${val4.name}");

}

void test1(int i) {
  i *= 2;
  print("test1=$i");
}

void test2(String s) {
  s += "append";
  print("test2=$s");
}

void test3(List<String> l) {
  l.add("Harley");
  print("test3=$l");
}

void test4(User u) {
  u.name = "fuga";
  print("test4=${u.name}");
}

class User {
  String name = "";
  User(this.name) {
  }
}