import 'package:alisveris/MyApp.dart';
import 'package:alisveris/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'repository/authentication_repository.dart';
// import 'package:get/get.dart';

Future<void> main() async {
  // debugRepaintRainbowEnabled = true;

  // ignore: unused_local_variable
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}
