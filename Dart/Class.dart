
void main() {

  // コンストラクタ
  User user = User("Honda", 30);
  //User user = User();
  //User user = User(name: "Honda", age: 30);

  // セッターとゲッター
  user.nickName = "fuga";
  print(user.nickName);

  user.dump();

  // Static
  print(User.COMPANY);
  User.execute();

  // サブクラス
  SpecialUser spu = SpecialUser("Yamaha", 40);
  spu.dump();
}

class User {

  // プロパティ
  String name;
  int age;
  late String str; // コンストラクタで定義されていない変数は、ここで初期値をつけるか、late修飾子
  String _nickName = ""; // アンスコでプライベート変数になる

  // 定数はconstかfinal
  final ageMax = 120;

  // コンストラクタ
  User(this.name, this.age) {
    _nickName = "hoge";
  }
  /*
  User() {
  }*/
  /*
  User({String name = "", int age = 10}) {
    this.name = name;
    this.age = age;
  }*/

  // インスタンスメソッド
  void dump() {
    print("$name $age $_nickName $ageMax");
  }

  // Setter
  set nickName(String s) {
    _nickName = s;
  }
  // Getter
  String get nickName {//=> _nickName;
    return _nickName;
  }
  // クラスメソッド
  static const String COMPANY = "Toyota";
  static void execute() {
    print(COMPANY);
  }
}

// サブクラス
class SpecialUser extends User {

  // コンストラクターは継承されない
  SpecialUser(String name, int age): super(name, age) {
    // なお、コンストラクタのボディ内で親クラスのコンストラクタを呼び出すことはできない
  } 

  @override
  void dump() {
    print("SpecialUser $name $age $_nickName $ageMax");
    // 親クラスを呼び出すこともできる
    super.dump();
  }
}