
void main(){

  /////////// 配列 ///////////
  
  // 生成
  List<String> ary = [];
  ary = ["Honda", "Yamaha", "Kawasaki"];
  print(ary);

  // アクセス
  print(ary[0]);
  print(ary.indexOf("Yamaha"));

  // 要素の追加
  ary.add("Suzuki");
  print(ary);
  ary.insert(1, "Harley");
  print(ary);

  // 要素の削除
  ary.remove("Harley");
  print(ary);
  ary.removeAt(0);
  print(ary);
  ary.removeLast();
  print(ary);
  ary.clear();
  print(ary);

  // 要素数
  ary = ["Honda", "Yamaha", "Kawasaki"];
  print(ary.length);

  // 走査
  for (var name in ary) {
    print(name);
  }
  ary.forEach((name){
    print(name);
  });
  for (var i = 0; i < ary.length; i++) {
    print(ary[i]);
  }

  // 存在確認
  print(ary.isEmpty);
  print(ary.contains("Kawasaki"));

  // Shallow Copy
  List<String> clone = ary;

  // Deep Copy
  List<String> clone2 = [...ary];

  ary.add("Toyota");
  print(clone);
  print(clone2);


  /////////// 辞書 ///////////
  
  // 生成
  Map<String, int> map = {};
  map = {"tokyo": 0, "osaka": 1, "hakata": 2};

  // アクセス
  print(map["osaka"]);

  // 要素の追加
  map.addAll({"nagoya": 3});
  print(map);

  // 要素の削除
  map.remove("nagoya");
  print(map);
  map.clear();
  print(map);

  // 要素数
  map = {"tokyo": 0, "osaka": 1, "hakata": 2};
  print(map.length);

  // 走査
  for (var key in map.keys) {
    print('$key : ${map[key]}');
  }
  for (var value in map.values) {
    print(value);
  }
  map.forEach((var key, var value) {
    print('$key : $value');
  });

  // 存在確認
  print(map.isEmpty);
  print(map.containsKey("tokyo"));
  print(map.containsValue(1));

  // Shallow Copy
  Map<String, int> cloneMap = map;

  // Deep Copy
  Map<String, int> cloneMap2 = {...map};

  map.addAll({"sapporo": 3});
  print(cloneMap);
  print(cloneMap2);


  /////////// セット型 ///////////
  
  // 生成
  Set<String> mySet = {};
  mySet = {"Honda", "Yamaha", "Kawasaki"};
  print(mySet);

  // 追加と削除
  mySet.add("Suzuki");
  print(mySet);
  mySet.remove("Honda");
  print(mySet);

  // 存在確認
  print(mySet.isEmpty);
  print(mySet.contains("Yamaha"));
  
}