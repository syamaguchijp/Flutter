import 'dart:convert';

main() {

  var jsonString = '''
    [
      {"name": "taro", "age": 30, "pref": "tokyo"},
      {"name": "jiro", "age": 20, "pref": "osaka"}
    ]
  ''';

  var persons = jsonDecode(jsonString);
  for (var person in persons) {
    print("${person['name']} ${person['age']} ${person['pref']}");
  }

  var jsonArray = [
      {"name": "taro", "age": 30, "pref": "tokyo"},
      {"name": "jiro", "age": 20, "pref": "osaka"}
    ];
  var jsonString2 = jsonEncode(jsonArray);
  print(jsonString2);

}
