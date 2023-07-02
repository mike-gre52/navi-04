import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';

class OrderCell extends StatelessWidget {
  Restaurant restaurant;
  RestaurantOrder order;
  Function onSubmit;

  OrderCell({
    Key? key,
    required this.restaurant,
    required this.order,
    required this.onSubmit,
  }) : super(key: key);

  showPopup(
    BuildContext context,
    String header,
    String subHeader,
  ) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(header),
        content: Text(subHeader),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('Yes'),
            onPressed: () {
              restaurantController.deleteOrder(restaurant, order);
              Navigator.pop(context);
              onSubmit();
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height15 = screenHeight / 59.733;
    double height25 = screenHeight / 35.84;
    double width10 = screenWidth / 41.4;
    double fontSize16 = screenHeight / 56;
    double fontSize20 = screenHeight / 44.8;

    return Container(
      margin: EdgeInsets.only(top: height15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                order.name,
                style: TextStyle(
                  fontSize: fontSize20,
                  color: black,
                  fontWeight: FontWeight.w600,
                  height: 0.8,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getAddOrderScreen(),
                            arguments: [restaurant, onSubmit, order, true]);
                      },
                      child: Icon(
                        Icons.edit_rounded,
                        size: height25,
                      ),
                    ),
                    SizedBox(width: width10),
                    GestureDetector(
                      onTap: () {
                        showPopup(
                          context,
                          "Are you sure you want to delete this order",
                          "",
                        );
                      },
                      child: Icon(
                        Icons.close_rounded,
                        size: height25,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Text(
            order.item,
            style: TextStyle(
              fontSize: fontSize16,
              color: darkGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
