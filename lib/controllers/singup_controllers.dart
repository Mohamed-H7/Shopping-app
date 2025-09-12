import 'package:alisveris/models/user_model.dart';
import 'package:alisveris/repository/authentication_repository.dart';
import 'package:alisveris/repository/user_respository.dart';
import 'package:alisveris/secreens/authentication/screens/login/login.dart';
import 'package:alisveris/secreens/loading_screen/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../secreens/loading_screen/loading_screen.dart';
import '../utils/helpers/network_manager.dart';
// import '../secreens/authentication/screens/login/login.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  var isloding = false.obs;

  final SifreSaklamak = true.obs;
  final SifreSaklamak2 = true.obs;
  final email = TextEditingController();
  final ad = TextEditingController();
  final soyad = TextEditingController();
  final kullaniciAd = TextEditingController();
  final sifre = TextEditingController();
  final sifre2 = TextEditingController();
  final telefon = TextEditingController();
  GlobalKey<FormState> singupFormKey = GlobalKey<FormState>();

  /// -- SIGNUP
  void signup() async {
    try {
      isloding.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isloding.value = false;
        return;
      }

      if (!singupFormKey.currentState!.validate()) {
        isloding.value = false;
        return;
      }

      final isUsernameTaken = await AuthenticationRepository.instance
          .isUsernameExists(kullaniciAd.text.trim());

      if (isUsernameTaken) {
        isloding.value = false;
        Loaders.warningSnackBar(
          title: 'Kullanıcı adı zaten mevcut!',
          message: 'Lütfen başka bir kullanıcı adı seçin.',
        );
        return;
      }
      final isPhoneNumberTaken = await AuthenticationRepository.instance
          .isPhoneNumberExists(telefon.text.trim());

      if (isPhoneNumberTaken) {
        isloding.value = false;
        Loaders.warningSnackBar(
          title: 'Telefon numarası zaten kullanılıyor!',
          message: 'Lütfen başka bir Telefon numarası seçin.',
        );
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), sifre.text.trim());

      final newUser = UserModel(
          id: userCredential.user!.uid,
          username: kullaniciAd.text.trim(),
          email: email.text.trim(),
          firstName: ad.text.trim(),
          lastName: soyad.text.trim(),
          phoneNumber: telefon.text.trim());

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // LoaderScreen.stop();
      isloding.value = false;

      // Get.to(() => const LoginScreen());
      Get.offAll(() => const LoginScreen());
      Loaders.successSnackBar(
          title: 'Tebrikler',
          message: 'Hesap başarıyla oluşturuldu, giriş yapabilirsiniz');

      // Get.to(() => const SignupState());
    } catch (e) {
      print("======= BigHata in sign up =============");
      print(e);
      // LoaderScreen.stop();
      isloding.value = false;
      // Loaders.errorSnackBar(title: 'Hata!', message: e.toString());
      switch (e) {
        case 'email-already-in-use':
          Loaders.warningSnackBar(
              title: 'E-posta zaten kullanılıyor!',
              message: 'Lütfen başka bir e-posta seçin');
          break;
        case 'invalid-email':
          Loaders.warningSnackBar(title: 'E-posta geçersiz!', message: '');
          break;
        case 'operation-not-allowed':
          Loaders.warningSnackBar(
              title: 'Hesap kaydı şu anda kullanılamıyor!', message: '');

          break;

        case 'network-request-failed':
          Loaders.errorSnackBar(
              title: 'İnternet bağlantısı yok!',
              message:
                  'Lütfen internet bağlantınızı kontrol edin ve tekrar deneyin.');
          break;

        default:
          Loaders.errorSnackBar(
              title: 'Kayıt sırasında bir hata oluştu!',
              message: 'Lütfen tekrar deneyin');

          break;
      }
    }
  }
}
