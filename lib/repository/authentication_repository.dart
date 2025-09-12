import 'package:alisveris/navigation_menu.dart';
import 'package:alisveris/utils/local_storge/storge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../secreens/authentication/screens/login/login.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    // Get.offAll(() => const WelcomeScreen());
    // Get.offAll(() => const LoginScreen());
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      await LocalStorage.init(user.uid); //
      Get.offAll(() => const NavigationMenu());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  ///Sign in
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("======= Hata 1 (Sign in)=============");
      print(e.code);
      switch (e.code) {
        case 'user-not-found':
          throw 'user-not-found';
        case 'wrong-password':
          throw 'wrong-password';
        case 'invalid-email':
          throw 'invalid-email';
        case 'user-disabled':
          throw 'user-disabled';
        case 'network-request-failed':
          throw 'network-request-failed';
        case 'too-many-requests':
          throw 'too-many-requests';
        case 'unknown':
          throw 'unknown-error';
        default:
          throw 'err-in-information';
      }
    } on FirebaseException catch (e) {
      print("======= Hata 2 (Sign in)=============");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } on FormatException catch (_) {
      print("======= Hata 3 (Sign in)=============");
      throw 'Something went wrong. Please try again';
    } on PlatformException catch (e) {
      print("======= Hata 4 (Sign in)=============");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } catch (e) {
      print("======= Hata 5 (Sign in)=============");
      throw 'Something went wrong. Please try again';
    }
  }

  ///Uye ol
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("======= Hata1 in sing up=============");
      print(e);
      switch (e.code) {
        case 'email-already-in-use':
          throw 'email-already-in-use';
        case 'invalid-email':
          throw 'invalid-email';
        case 'operation-not-allowed':
          throw 'operation-not-allowed';
        case 'weak-password':
          throw 'weak-password';
        case 'network-request-failed':
          throw 'network-request-failed';
        case 'too-many-requests':
          throw 'too-many-requests';
        case 'unknown':
          throw 'unknown-error';
        default:
          throw 'Something went wrong. Please try again';
      }
    } on FirebaseException catch (e) {
      print("=======$e Hata2=============");
      throw 'Something went wrong. Please try again';
    } on FormatException catch (_) {
      print("======= Hata3=============");
      throw 'Something went wrong. Please try again';
    } on PlatformException catch (e) {
      print("=======$e Hata4=============");
      throw 'Something went wrong. Please try again';
    } catch (e) {
      print("=======$e Hata5=============");
      throw 'Something went wrong. Please try again';
    }
  }

  ///Cikis Yap
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      print("======= Hata 1 (Cikis Yap)===========");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } on FirebaseException catch (e) {
      print("======= Hata 2 (Cikis Yap)===========");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } on FormatException catch (_) {
      print("======= Hata 3 (Cikis Yap)===========");
      throw 'Something went wrong. Please try again';
    } on PlatformException catch (e) {
      print("======= Hata 1 (Cikis Yap)===========");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //forget password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("======= Hata 1 (forget password)===========");
      print(e.code);

      switch (e.code) {
        case 'user-not-found':
          throw 'user-not-found';
        case 'invalid-email':
          throw 'invalid-email';
        case 'network-request-failed':
          throw 'network-request-failed';
        case 'too-many-requests':
          throw 'too-many-requests';
        case 'unknown':
          throw 'unknown-error';
        default:
          throw 'Something went wrong. Please try again';
      }
    } on FirebaseException catch (e) {
      print("======= Hata 2 (forget password)===========");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } on FormatException catch (_) {
      print("======= Hata 3 (forget password)===========");
      throw 'Something went wrong. Please try again';
    } on PlatformException catch (e) {
      print("======= Hata 4 (forget password)===========");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //search if username/email avalible or not:
  Future<bool> isUsernameExists(String newKullanici) async {
    try {
      var querySnapshot = await _db
          .collection('Users')
          .where('Username', isEqualTo: newKullanici)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking username: $e');
      return false;
    }
  }

  Future<bool> isPhoneNumberExists(String newPhoneNumber) async {
    try {
      var querySnapshot = await _db
          .collection('Users')
          .where('PhoneNumber', isEqualTo: newPhoneNumber)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking username: $e');
      return false;
    }
  }

  Future<bool> isEmailExists(String newEmail) async {
    try {
      var querySnapshot = await _db
          .collection('Users')
          .where('Email', isEqualTo: newEmail)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email: $e');
      return false;
    }
  }

  //Sign in with number:
  Future<void> loginWithPhoneNumber(String number) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print("======= Hata in loginWithPhoneNumber =============");
          print(e.code);

          switch (e.code) {
            case 'invalid-phone-number':
              throw 'invalid-phone-number';
            case 'too-many-requests':
              throw 'too-many-requests';
            case 'quota-exceeded':
              throw 'quota-exceeded';
            default:
              throw 'Something went wrong. Please try again*';
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          AuthenticationRepository.instance.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          AuthenticationRepository.instance.verificationId = verificationId;
        },
      );
    } on FirebaseException catch (e) {
      print("======= hata 2 in loginWithPhoneNumber =============");
      print(e.code);
      throw 'Something went wrong. Please try again**';
    } on PlatformException catch (e) {
      print("======= hata 3 in loginWithPhoneNumber =============");
      print(e.code);
      throw 'Something went wrong. Please try again***';
    } catch (e) {
      print("======= hata 4 in loginWithPhoneNumber =============");
      throw 'Something went wrong. Please try again****';
    }
  }

  String? verificationId;

  Future<UserCredential> verifyOtpCode(String otpCode) async {
    try {
      if (verificationId == null) {
        throw 'لم يتم العثور على معرف التحقق، يرجى إعادة المحاولة.';
      }

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otpCode,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print("======= hata in verifyOtpCode =============");
      print(e.code);

      switch (e.code) {
        case 'invalid-verification-code':
          throw 'invalid-verification-code';
        case 'session-expired':
          throw 'session-expired';
        default:
          throw 'Something went wrong. Please try again';
      }
    } catch (e) {
      print("======= hata 2 in verifyOtpCode =============");
      print(e.toString());
      throw 'Something went wrong. Please try again';
    }
  }
}
