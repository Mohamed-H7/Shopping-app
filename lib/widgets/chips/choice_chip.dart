import 'package:flutter/material.dart';

import '../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/circular_container.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = HelperFunctions.getColor(text) != null;

    return ChoiceChip(
      label: isColor ? const SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(
        color: selected ? Colors.white : null,
      ),
      avatar: isColor
          ? CircularContainer(
              width: 50,
              height: 50,
              backgroundColor: HelperFunctions.getColor(text)!,
            )
          : null,
      labelPadding: isColor ? const EdgeInsets.all(0) : null,
      padding: isColor ? const EdgeInsets.all(0) : null,
      shape: isColor ? const CircleBorder() : null,
      backgroundColor: isColor ? HelperFunctions.getColor(text)! : null,
    );
  }
}
