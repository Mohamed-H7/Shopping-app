import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/user_controllers.dart';
import '../../../../../widgets/appbar/appbar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return SAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Merhaba!",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: const Color.fromARGB(255, 223, 223, 223))),
          Obx(
            () => Text(controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
