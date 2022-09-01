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

  Widget buildMemberCell(String name, String color) => GroupMember(
        circleText: name,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Member>>(
        stream: groupController.getGroupMembers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return Container(
              height: 60,
              width: double.maxFinite,
              child: Stack(
                children: List.generate(
                  data.length,
                  (index) => Positioned(
                    left: index * 40,
                    child: buildMemberCell(data[index].name, data[index].color),
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
