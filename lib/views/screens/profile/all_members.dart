import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';
import 'package:whats_for_dinner/views/widgets/app/header.dart';
import 'package:whats_for_dinner/views/widgets/profile/group_member.dart';
import 'package:whats_for_dinner/views/widgets/home/home_header.dart';
import 'package:whats_for_dinner/views/widgets/profile/all_group_members.dart';
import 'package:whats_for_dinner/views/widgets/profile/group_members.dart';
import 'package:whats_for_dinner/views/widgets/profile/select_color.dart';

class AllMembersScreen extends StatefulWidget {
  const AllMembersScreen({Key? key}) : super(key: key);

  @override
  State<AllMembersScreen> createState() => _AllMembersScreenState();
}

class _AllMembersScreenState extends State<AllMembersScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height20 = screenHeight / 44.8;
    return Scaffold(
      body: StreamBuilder<List<Member>>(
        stream: groupController.getGroupMembers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return Column(
              children: [
                AppHeader(
                  headerText: 'Members',
                  headerColor: Colors.white,
                  borderColor: royalYellow,
                  textColor: black,
                  dividerColor: royalYellow,
                  rightAction: Text(
                    'Back',
                    style: TextStyle(
                      color: black,
                      fontSize: height20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onIconClick: () {
                    //pop screen
                    Navigator.pop(context);
                  },
                ),
                AllGroupMembers(members: data),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
