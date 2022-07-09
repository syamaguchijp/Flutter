main() {

  try {
    MyCustomClass().execute();

  } on FormatException catch(e) {
    print("catch FormatException ${e.toString()}");

  } catch(e) {
    print("catch ${e.toString()}");
    
  } finally {
    print("finally");
  }
}

// 例外を投げるメソッドをもつクラス
class MyCustomClass {

  void execute() {
    print("execute");
    throw new FormatException("hoge");
    //throw new Error();
    //throw MyCustomError();
  }
}

// 自作のエラー
class MyCustomError extends StateError {
  MyCustomError() : super("MyCustomError");
}
