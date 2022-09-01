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
    Color memberColor = royalYellow;
    memberColor = Color(int.parse(color));
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: 15,
                  left: 30,
                ),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
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
                        fontSize: 25,
                        color: memberColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    name.substring(0, 1).toUpperCase() + name.substring(1),
                    style: TextStyle(
                      fontSize: 20,
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
