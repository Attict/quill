import 'package:quill/quill.dart';
import 'dart:ui';
import 'dart:math';

void main() async {
  new QuillEngine(new Application())..start();
}

class Application extends Feather {
  @override
  void init() {
    super.init();
    Sprite user = new Sprite()..initWithColor(const Color(0xFFFF0000), 
        const Point(-100.0, 0.0), const Size(100.0, 100.0));

    addFeather('user', user);
  }
}

