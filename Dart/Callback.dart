
void main() {

  execute(callbackMethod);

  execute((String s){print(s);});

}

void callbackMethod(String s) {
  print(s);
}

void execute(callbackMethod) {
  callbackMethod("execute");
}