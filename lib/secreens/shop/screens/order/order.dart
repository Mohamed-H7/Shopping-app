import 'package:flutter/material.dart';

import '../../../../utils/constans/sizes.dart';
import '../../../../widgets/appbar/appbar.dart';
import 'widgets/order_list_item.dart';

class OrderScreens extends StatelessWidget {
  const OrderScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Geçmiş Alışveriş',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(Sizes.defaultSpace),
        //
        child: OrderListItem(),
      ),
    );
  }
}
