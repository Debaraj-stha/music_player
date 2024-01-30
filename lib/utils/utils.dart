import 'package:flutter/foundation.dart';

class Utils {
 static void printMessage(String data) {
    if (kDebugMode) {
      print(data.toString());
    }
  }
}
