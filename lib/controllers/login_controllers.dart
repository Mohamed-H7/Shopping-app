import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';
import '../repository/authentication_repository.dart';
import '../repository/user_respository.dart';
import '../secreens/authentication/screens/login/widgets/Otb/OtpVerificationScreen.dart';
import '../secreens/authentication/screens/login/widgets/newUserWithTel.dart';
import '../secreens/loading_screen/loaders.dart';
// import '../secreens/loading_screen/loading_screen.dart';
import '../utils/helpers/network_manager.dart';

class LoginController extends GetxController {
  var isloding = false.obs;

  final BeniHatirla = false.obs;
  final SifreSaklamak = true.obs;
  final localStorge = GetStorage();
  final email = TextEditingController();
  final sifre = TextEditingController();
  final telefoneNum = TextEditingController(text: "+90");
  final code = TextEditingController();

  //New user variebale:
  final ad = TextEditingController();
  final soyad = TextEditingController();
  final kullanici = TextEditingController();
  final newEmail = TextEditingController();

  GlobalKey<FormState> LoginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> LoginFormKeyTel = GlobalKey<FormState>();
  GlobalKey<FormState> LoginFormCode = GlobalKey<FormState>();
  GlobalKey<FormState> newUserForm = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorge.read('REMEMBER_ME_EMAIL') ?? '';
    sifre.text = localStorge.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      isloding.value = true;
      // LoaderScreen.showLoadingDialog();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      if (!LoginFormKey.currentState!.validate()) {
        return;
      }

      if (BeniHatirla.value) {
        localStorge.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorge.write('REMEMBER_ME_PASSWORD', sifre.text.trim());
      }

      // ignore: unused_local_variable
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), sifre.text.trim());

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      print("======= BigHata in login=============");
      print(e);

      switch (e) {
        case 'user-not-found':
          Loaders.errorSnackBar(
              title: 'Kullanıcı bulunamadı!',
              message: 'Lütfen e-postanızı kontrol edin');
          break;
        case 'wrong-password':
          Loaders.errorSnackBar(
              title: 'Şifre yanlış!', message: 'Lütfen tekrar deneyin');

          break;
        case 'invalid-email':
          Loaders.errorSnackBar(
              title: 'E-posta geçersiz!', message: 'Lütfen tekrar deneyin');

          break;

        case 'network-request-failed':
          Loaders.errorSnackBar(
              title: 'İnternet bağlantısı yok!',
              message:
                  'Lütfen internet bağlantınızı kontrol edin ve tekrar deneyin.');
          break;

        default:
          Loaders.errorSnackBar(
              title: 'Giriş bilgilerinizde hata var!',
              message: 'Lütfen kontrol edin');

          break;
      }
    } finally {
      isloding.value = false;
      // LoaderScreen.stop();
    }
  }

  Future<void> sendOtp() async {
    try {
      // LoaderScreen.showLoadingDialog();
      isloding.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // isloding.value = false;
        return;
      }

      if (!LoginFormKeyTel.currentState!.validate()) {
        // isloding.value = false;
        return;
      }

      await AuthenticationRepository.instance
          .loginWithPhoneNumber(telefoneNum.text.trim());

      Get.to(const OtpVerificationScreen());
    } catch (e) {
      Loaders.errorSnackBar(title: 'Hata', message: e.toString());
    } finally {
      isloding.value = false;
    }
  }

  Future<void> verifyOtp() async {
    try {
      // LoaderScreen.showLoadingDialog();
      isloding.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isloding.value = false;
        return;
      }

      if (!LoginFormCode.currentState!.validate()) {
        isloding.value = false;
        return;
      }

      // ignore: unused_local_variable
      final userCredential = await AuthenticationRepository.instance
          .verifyOtpCode(code.text.trim());

      isloding.value = false;
      Loaders.successSnackBar(title: 'Doğrulama kodu doğru', message: '');

      if (userCredential.additionalUserInfo?.isNewUser == true) {
        Get.to(const NewUserScreen());
      } else {
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      isloding.value = false;
      Loaders.errorSnackBar(
          title: 'Doğrulama kodu geçersiz', message: ''); //e.toString()
    } finally {
      // LoaderScreen.stop();
    }
  }

  void saveTelAccInformation() async {
    try {
      isloding.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isloding.value = false;
        return;
      }

      if (!newUserForm.currentState!.validate()) {
        isloding.value = false;
        return;
      }

      final isUsernameTaken = await AuthenticationRepository.instance
          .isUsernameExists(kullanici.text.trim());

      if (isUsernameTaken) {
        isloding.value = false;
        Loaders.warningSnackBar(
          title: 'Kullanıcı adı zaten mevcut!',
          message: 'Lütfen başka bir kullanıcı adı seçin.',
        );
        return;
      }

      final isEmailTaken = await AuthenticationRepository.instance
          .isEmailExists(newEmail.text.trim());

      if (isEmailTaken) {
        isloding.value = false;
        Loaders.warningSnackBar(
          title: 'E-Posta zaten mevcut!',
          message: 'Lütfen başka bir E-Posta seçin.',
        );
        return;
      }

      String? userId = FirebaseAuth.instance.currentUser?.uid;
      print(userId);

      final newUser = UserModel(
          id: userId!,
          username: kullanici.text.trim(),
          email: newEmail.text.trim(),
          firstName: ad.text.trim(),
          lastName: soyad.text.trim(),
          phoneNumber: telefoneNum.text.trim());

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      isloding.value = false;

      AuthenticationRepository.instance.screenRedirect();

      Loaders.successSnackBar(
          title: 'Tebrikler', message: 'Verileriniz başarıyla kaydedildi');
    } catch (e) {
      print("======= BigHata in save tel acc inf.. =============");
      print(e);
      isloding.value = false;
      Loaders.errorSnackBar(
          title: 'Kayıt sırasında bir hata oluştu!',
          message: 'Lütfen tekrar deneyin');
    }
  }
}
