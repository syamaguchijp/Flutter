
void main() {

  execute(callbackMethod);

  execute((String s){print(s);});

  execute2((){print("execute2");});
}

void callbackMethod(String s) {
  print(s);
}

void execute(callbackMethod) {
  callbackMethod("execute");
}

void execute2(Function closure) {
  closure();
}
