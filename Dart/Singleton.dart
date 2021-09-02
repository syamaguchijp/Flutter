
void main() {

  MySingleton s1 = MySingleton();
  MySingleton s2 = MySingleton();
  print(s1 == s2);
  print(s1 is MySingleton);
  print(s2 is MySingleton);
}

class MySingleton {
  static MySingleton _instance = new MySingleton._();
  factory MySingleton() {
    if (_instance == null) {
      _instance = new MySingleton._();
    }
    return _instance;
  }
  const MySingleton._();
}