import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderScreen {
  static void showLoadingDialog() {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(), // مؤشر التحميل
                SizedBox(height: 20),
                Text("Yükleniyor...", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }

  static void stop() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
