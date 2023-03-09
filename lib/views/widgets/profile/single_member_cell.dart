import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class SingleMemberCell extends StatelessWidget {
  String name;
  String color;
  SingleMemberCell({
    required this.name,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height3 = screenHeight / 298.66667;
    double height15 = screenHeight / 59.733;
    double height60 = screenHeight / 14.933;
    double width10 = screenWidth / 41.4;
    double width15 = screenWidth / 27.6;
    double width30 = screenWidth / 13.8;
    double fontSize20 = screenHeight / 44.8;
    double fontSize24 = screenHeight / 37.333;

    Color memberColor = royalYellow;
    memberColor = Color(int.parse(color));
    return Container(
      margin: EdgeInsets.only(
        top: height15,
        bottom: height15,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: width15,
                  left: width30,
                ),
                height: height60,
                width: height60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: height3,
                    color: memberColor,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(180, 180, 180, 1.0),
                      offset: Offset(0.0, 1.0),
                      blurRadius: 3.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: fontSize24,
                      color: memberColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: width10),
                  child: Text(
                    name.substring(0, 1).toUpperCase() + name.substring(1),
                    style: TextStyle(
                      fontSize: fontSize20,
                      color: black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
