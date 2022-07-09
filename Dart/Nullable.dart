void main() {
  String? str; // null
  print(str);
  print(str ?? "null desu");

  str = "abc";
  if (str != null) {
    print(str);
    // str! としなければならない場合もある。
    // https://dart.dev/tools/non-promotion-reasons
  }

 

  





}