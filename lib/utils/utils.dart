import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Utils {
  static void printMessage(String data) {
    if (kDebugMode) {
      print(data.toString());
    }
  }

  void showSnackbar(String data, BuildContext context, {isWarning = true}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(data),
      backgroundColor: isWarning ? Colors.red : Colors.green,
      showCloseIcon: true,
      closeIconColor: Colors.black,
      padding: const EdgeInsets.all(6),
    ));
    print(data);
  }
}
