import 'package:flutter/gestures.dart';

class AllowVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);  //override rejectGesture here
  }
}