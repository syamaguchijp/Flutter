main() {

  Caller caller = Caller();
  caller.execute();
}

// mixinを利用したデリゲートパターン
mixin SomeCallbackDelegate {
  void didCallBack(int num);
}

class Callee {
    WeakReference<SomeCallbackDelegate>? delegate; // 弱参照

    void execute() {
      if (delegate != null) {
        delegate!.target!.didCallBack(10);
      }
    }
}

class Caller with SomeCallbackDelegate {

    Callee callee = Callee();

    Caller() {
        callee.delegate = WeakReference<SomeCallbackDelegate>(this);
    }

    void execute() {
      callee.execute();
    }

    void didCallBack(int num) {
        print("didCallBack!!!! ${num}");
    }
}
