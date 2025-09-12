import 'package:get/get.dart';

class HomeControllers extends GetxController {
  static HomeControllers get instance => Get.find();

  final courselCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    courselCurrentIndex.value = index;
  }
}
