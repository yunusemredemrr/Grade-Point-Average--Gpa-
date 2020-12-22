import 'dart:math';
import 'dart:ui';

class CreateColor{
  Color randomCreateColor() {
    return Color.fromARGB(150 + Random().nextInt(105), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}