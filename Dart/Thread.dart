import 'dart:isolate';
import 'dart:async';

main() {

  // Futureやasyncによる非同期処理
  /*
  executeFuture();
  executeFutureAwait();
  */

  // isolateによる並列処理（isolate is like thread）
  Isolate.spawn(executeIsolate1, null); // 3秒後
  Isolate.spawn(executeIsolate2, null); // 2秒後
  Isolate.spawn(executeIsolate3, null); // 1秒後
  Timer(const Duration(seconds: 5),  // これをつけないと、mainが終了してしまうため
    () {
      // isolate内で代入したはずのglobalValの値は更新されていないことを確認する。
      // メインスレッドとサブスレッド（isolate）は、メモリを共有していないということ。
      print("globalVal=${globalVal}");
      print("main end");
    });
}
int globalVal = 100;


/////// Futureやasyncによる非同期処理 //////

void executeFuture() {

  // 1秒後に実行
  Future<String> future = 
    Future.delayed(Duration(seconds: 1), () => "executeFutre");
  future.then((value) => print(value)); 
}

Future<void> executeFutureAwait() async {

  print("executeFutreAwait1");
  Future<String> future =
    Future.delayed(Duration(seconds: 2), () => "executeFutreAwait4");
  print("executeFutreAwait2"); // ここまでは同期処理で即座に進む。
  String value = await future; // このawait以降は、Futureの非同期処理が完了するまで待つ。
  print("executeFutreAwait3");
  print(value);
}


/////// isolateによる並列処理（isolate is like thread） //////

void executeIsolate1(arg) {

  globalVal = 99; // グローバル変数の値を変えてみる
  Timer(const Duration(seconds: 3), 
    () {
      print("executeIsolate1 globalVal=${globalVal}");
    });
}

void executeIsolate2(arg) {

  Timer(const Duration(seconds: 2), 
    () {
      print("executeIsolate2");
    });
}

void executeIsolate3(arg) {

  Timer(const Duration(seconds: 1), 
    () {
      print("executeIsolate3");
    });
}

