import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/cart_controller.dart';
import '../../../../../utils/constans/sizes.dart';
import '../../../../../widgets/products/cart/cart_item.dart';
import '../../../../../widgets/products/product_title_text/product_price_text.dart';
import 'add_minus.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveBtn = true});

  final bool showAddRemoveBtn;

  @override
  Widget build(BuildContext context) {
    // final controller = SepetController.instance;
    final cartController = CartController.instance;
    return Obx(() => ListView.separated(
          shrinkWrap: true,
          itemCount: cartController.cartItems.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: Sizes.spaceBtwSections),
          itemBuilder: (_, index) => Obx(() {
            final item = cartController.cartItems[index];
            return Column(
              children: [
                CartItem(
                  showAdetText: !showAddRemoveBtn,
                  cartItem: item,
                ),
                if (showAddRemoveBtn)
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                if (showAddRemoveBtn)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // SizedBox(
                          //   width: 0,
                          // ),
                          AddMinusBtn(
                            miktar: item.miktar,
                            add: () => cartController.addOneToCart(item),
                            remove: () =>
                                cartController.removeOneFromCart(item),
                          ),
                        ],
                      ),
                      ProductPriceText(
                          price: (item.fiyat * item.miktar).toStringAsFixed(2)),
                    ],
                  ),
              ],
            );
          }),
        ));
  }
}





// FutureBuilder(
//           future: controller.sepetProducts(),
//           builder: (context, snapshot) {
//             const emptyW = Center(
//               child: Text("Sepete ürün yok"),
//             );

//             final response = CloudHelperFunctions.checkMultiRecordState(
//                 snapshot: snapshot, nothingFound: emptyW);
//             if (response != null) return response;

//             final urunler = snapshot.data!;
//             return ListView.separated(
//               shrinkWrap: true,
//               itemCount: urunler.length,
//               separatorBuilder: (_, __) =>
//                   const SizedBox(height: Sizes.spaceBtwSections),
//               itemBuilder: (_, index) => Column(
//                 children: [
//                   CartItem(
//                     title: urunler[index].title,
//                     marka: urunler[index].marka_id,
//                     fiyat: urunler[index].fiyat,
//                     image: urunler[index].image,
//                     urunID: urunler[index].id,
//                   ),
//                 ],
//               ),
//             );
//           }),
