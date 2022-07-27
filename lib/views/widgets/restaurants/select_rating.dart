import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SelectRating extends StatelessWidget {
  int rating;
  Function onTap;
  SelectRating({
    Key? key,
    required this.onTap,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: List.generate(
          5,
          (index) => GestureDetector(
            onTap: () {
              onTap(index);
            },
            child: Icon(
              index < rating ? Icons.star_rounded : Icons.star_outline_rounded,
              size: 40,
              color: Color.fromRGBO(255, 193, 7, 1.0),
            ),
          ),
        ),
      ),
    );
  }
}
