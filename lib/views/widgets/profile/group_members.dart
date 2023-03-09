import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/profile/group_member.dart';

class GroupMembers extends StatelessWidget {
  const GroupMembers({
    Key? key,
  }) : super(key: key);

  Widget buildMemberCell(String name, String color, bool isExtra) =>
      GroupMember(
        circleText: name,
        color: color,
        isExtra: isExtra,
      );

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height50 = screenHeight / 17.92;
    double height60 = screenHeight / 14.933;
    double width40 = screenWidth / 10.35;

    return StreamBuilder<List<Member>>(
        stream: groupController.getGroupMembers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return Container(
              height: height60,
              width: double.maxFinite,
              child: Stack(
                children: List.generate(
                  6,
                  (index) => Positioned(
                    left: index * width40,
                    child: index == 5 && data.length > 6
                        ? buildMemberCell(
                            "+${data.length - index}", data[index].color, true)
                        : buildMemberCell(
                            data[index].name, data[index].color, false),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
