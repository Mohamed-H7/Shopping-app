import 'package:alisveris/utils/constans/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constans/colors.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({
    super.key,
    required this.msg,
    required this.not,
    this.onPressed,
    this.durum = true,
  });
  final String msg, not;
  final VoidCallback? onPressed;
  final bool durum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Icon(
                //   Iconsax.tick_circle4,
                //   size: 80,
                //   color: Colors.green,
                // ),

                Container(
                  decoration: BoxDecoration(
                    color: durum ? TColors.primary : Colors.red, //Colors.green
                    shape: BoxShape.circle,
                  ),
                  child: durum
                      ? const Icon(
                          Iconsax.tick_circle4,
                          size: 80,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.error_outline_outlined,
                          size: 80,
                          color: Colors.white,
                        ),
                ),

                const SizedBox(height: Sizes.spaceBtwItems),
                //text
                Text(msg,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: Sizes.spaceBtwItems),
                if (not.isNotEmpty)
                  Text(not,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium),
                if (not.isNotEmpty)
                  const SizedBox(height: Sizes.spaceBtwSections),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: onPressed, child: const Text("Tamamlandı")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
