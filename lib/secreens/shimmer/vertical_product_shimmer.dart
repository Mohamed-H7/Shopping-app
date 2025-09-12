import 'package:alisveris/secreens/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../../utils/constans/sizes.dart';
import '../../widgets/layouts/grid_layout.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ShimmerEffect(width: 180, height: 180),
            SizedBox(height: Sizes.spaceBtwItems),

            /// Text
            ShimmerEffect(width: 160, height: 15),
            SizedBox(height: Sizes.spaceBtwItems / 2),
            ShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}
