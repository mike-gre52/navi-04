import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class RestaurantCell extends StatelessWidget {
  String name;
  int rating;
  int price;
  bool doesDelivery;
  int time;
  bool isFavorite;
  RestaurantCell({
    required this.name,
    required this.rating,
    required this.price,
    required this.doesDelivery,
    required this.time,
    required this.isFavorite,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      height: 110,
      width: 380,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 176, 176, 176),
            offset: Offset(0.0, 1.0),
            blurRadius: 3.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(left: 30, top: 10, bottom: 10, right: 5),
        child: Row(
          children: [
            Container(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Wrap(
                    children: List.generate(
                      rating,
                      (index) => const Icon(
                        Icons.star_rounded,
                        size: 20,
                        color: Color.fromRGBO(255, 193, 7, 1.0),
                      ),
                    ),
                  ),
                  Text(
                    price == 1
                        ? '\$'
                        : price == 2
                            ? '\$\$'
                            : price == 3
                                ? '\$\$\$'
                                : '\$\$\$',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: appRed,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        doesDelivery
                            ? Icons.check_circle_outline
                            : Icons.remove_circle_outline,
                        size: 35,
                        color: doesDelivery ? green : red,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Delivery',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 35,
                        color: royalYellow,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '$time min',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: 30),
            isFavorite
                ? Icon(
                    Icons.star_rounded,
                    size: 35,
                    color: appRed,
                  )
                : Icon(
                    Icons.star_outline_rounded,
                    size: 35,
                    color: appRed,
                  ),
          ],
        ),
      ),
    );
  }
}
