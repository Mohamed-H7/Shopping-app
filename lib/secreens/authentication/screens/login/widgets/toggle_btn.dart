import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constans/colors.dart';

class ToggleBtn extends StatelessWidget {
  const ToggleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectedlistControllers());
    return Container(
      padding: const EdgeInsets.all(5),
      height: 45,
      decoration: const BoxDecoration(
        color: TColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  controller.updateSelection(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: controller.isSelected[0] == true
                          ? Colors.white
                          : Colors.transparent),
                  child: Center(
                      child: Text(
                    "E-Posta",
                    style: Theme.of(context).textTheme.labelLarge?.apply(
                        color: controller.isSelected[0] == true
                            ? Colors.black
                            : Colors.white),
                  )),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  controller.updateSelection(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: controller.isSelected[1] == true
                          ? Colors.white
                          : Colors.transparent),
                  child: Center(
                      child: Text(
                    "Telefon",
                    style: Theme.of(context).textTheme.labelLarge?.apply(
                        color: controller.isSelected[1] == true
                            ? Colors.black
                            : Colors.white),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedlistControllers extends GetxController {
  static SelectedlistControllers get instance => Get.find();

  var isSelected = [true, false].obs;

  void updateSelection(index) {
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = i == index;
    }
  }
}
