import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/views/widgets/home/group_member.dart';

class GroupMembers extends StatelessWidget {
  List<Member> members;
  GroupMembers({
    Key? key,
    required this.members,
  }) : super(key: key);

  Widget buildMemberCell(String name, String color) => GroupMember(
        circleText: name,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.maxFinite,
      child: Stack(
        children: List.generate(
          members.length,
          (index) => Positioned(
            left: index * 40,
            child: buildMemberCell(members[index].name, members[index].color),
          ),
        ),
      ),
    );
  }
}
