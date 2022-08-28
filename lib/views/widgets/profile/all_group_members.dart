import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/views/widgets/profile/group_member.dart';
import 'package:whats_for_dinner/views/widgets/profile/single_member_cell.dart';

class AllGroupMembers extends StatelessWidget {
  List<Member> members;
  AllGroupMembers({
    Key? key,
    required this.members,
  }) : super(key: key);

  Widget buildMemberCell(String name, String color) => SingleMemberCell(
        name: name,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.maxFinite,
        child: ListView(
          padding: EdgeInsets.all(0),
          children: members
              .map((member) => buildMemberCell(member.name, member.color))
              .toList(),
        ),
      ),
    );
  }
}
