import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controllers.dart';
import '../images/circular_image.dart';

class UserProfileTitle extends StatelessWidget {
  const UserProfileTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return ListTile(
      leading: const CircularImage(
        image: "assets/images/user-profile.png",
        width: 52, //50
        height: 52, //50
        padding: 0,
      ),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: Colors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
      ),
    );
  }
}
