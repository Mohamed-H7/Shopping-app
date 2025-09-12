import 'package:alisveris/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../secreens/loading_screen/loaders.dart';
// import '../secreens/loading_screen/loading_screen.dart';
import '../utils/helpers/network_manager.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Variables
  var isloding = false.obs;
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start Loading
      // LoaderScreen.showLoadingDialog();
      isloding.value = true;

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // LoaderScreen.stop();
        isloding.value = false;
        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        // LoaderScreen.stop();
        isloding.value = false;
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // LoaderScreen.stop();
      isloding.value = false;

      Loaders.successSnackBar(
          title: 'Şifreniz Gönderildi',
          message:
              '(${email.text.trim()}) adresine şifre yenileme linkiniz gönderildi.');
      email.clear();
    } catch (e) {
      print("======= BigHata in Reset Password=============");
      print(e);
      // LoaderScreen.stop();
      isloding.value = false;

      switch (e) {
        case 'user-not-found':
          Loaders.errorSnackBar(
              title: 'E-posta adresiniz bizde kayıtlı değil!');
          break;
        case 'invalid-email':
          Loaders.errorSnackBar(title: 'E-posta geçersiz!');
          break;
        case 'network-request-failed':
          Loaders.errorSnackBar(
              title: 'İnternet bağlantısı yok!',
              message:
                  'Lütfen internet bağlantınızı kontrol edin ve tekrar deneyin.');
          break;
        default:
          Loaders.errorSnackBar(
              title: 'Şifrenizi sıfırlamaya çalışırken bir hata oluştu!',
              message: 'Lütfen tekrar deneyin');

          break;
      }
    }
  }
}
