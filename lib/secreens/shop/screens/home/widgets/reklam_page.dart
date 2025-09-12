import 'package:flutter/material.dart';

import '../../../../../utils/constans/sizes.dart';

class ReklamPage extends StatelessWidget {
  const ReklamPage({super.key, required this.img});

  final String img;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        // TRoundedImage(
        //   imageUrl: img,
        // ),
        //
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.md),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.md),
            child: Image(
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
              fit: BoxFit.cover,
              image: AssetImage(img) as ImageProvider,
            ),
          ),
        ),
        //
        const SizedBox(width: Sizes.spaceBtwItems),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Kacirma!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: Colors.black, fontWeightDelta: 2)),
              const Text("Air Max 2090",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w900)),
              const SizedBox(height: 5),
              SizedBox(
                width: screenWidth * 0.3,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(80, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Satin Al'),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
