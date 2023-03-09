import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SelectRating extends StatelessWidget {
  int rating;
  Function onTap;
  bool isTapable;
  SelectRating({
    Key? key,
    required this.onTap,
    required this.rating,
    required this.isTapable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height35 = screenHeight / 25.6;

    return Container(
      child: Wrap(
        children: List.generate(
          5,
          (index) => isTapable
              ? GestureDetector(
                  onTap: () {
                    onTap(index);
                  },
                  child: Icon(
                    index < rating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    size: height35,
                    color: const Color.fromRGBO(255, 193, 7, 1.0),
                  ),
                )
              : Icon(
                  index < rating
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  size: height35,
                  color: const Color.fromRGBO(255, 193, 7, 1.0),
                ),
        ),
      ),
    );
  }
}
