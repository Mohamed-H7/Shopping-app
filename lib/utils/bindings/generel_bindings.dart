import 'package:get/get.dart';

import '../helpers/network_manager.dart';

class GenerelBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
