import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/views/widgets/home/group_member.dart';

class GroupMembers extends StatelessWidget {
  List<String> members;
  GroupMembers({
    Key? key,
    required this.members,
  }) : super(key: key);

  Widget buildMemberCell(String name) => GroupMember(circleText: name);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.maxFinite,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: members.map((name) => buildMemberCell(name)).toList(),
      ),
    );
  }
}
