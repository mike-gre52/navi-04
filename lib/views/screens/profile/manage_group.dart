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
import 'package:whats_for_dinner/views/widgets/profile/group_members.dart';
import 'package:whats_for_dinner/views/widgets/profile/select_color.dart';

class ManageGroupScreen extends StatefulWidget {
  const ManageGroupScreen({Key? key}) : super(key: key);

  @override
  State<ManageGroupScreen> createState() => _ManageGroupScreenState();
}

class _ManageGroupScreenState extends State<ManageGroupScreen> {
  final TextEditingController _groupNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Group>(
        stream: groupController.getGroupData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Group group = snapshot.data!;
            _groupNameController.text = group.groupName;
            return Column(
              children: [
                AppHeader(
                  headerText: group.groupName,
                  headerColor: Colors.white,
                  borderColor: royalYellow,
                  textColor: black,
                  dividerColor: royalYellow,
                  rightAction: Text(
                    'Back',
                    style: TextStyle(
                      color: black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onIconClick: () {
                    //pop screen
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          'Group Name',
                          style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomTextfield(
                        icon: Icons.groups_rounded,
                        placeholderText: '',
                        controller: _groupNameController,
                        borderColor: royalYellow,
                        textfieldWidth: double.maxFinite,
                        textfieldHeight: 60,
                        borderRadius: 10,
                        onSubmit: (_) {},
                        onChanged: (_) {},
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Header(
                            headerText: 'Members',
                            dividerColor: royalYellow,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.allMembers);
                            },
                            child: Text(
                              'All members',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: royalYellow),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const GroupMembers(),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.selectColor);
                        },
                        child: Text(
                          'Edit Color',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: royalYellow),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Header(
                          headerText: 'Group Code', dividerColor: royalYellow),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: royalYellow.withAlpha(75),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              group.groupId,
                              style: TextStyle(
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: (() {
                                Clipboard.setData(
                                    ClipboardData(text: group.groupId));
                              }),
                              child: const Icon(
                                Icons.content_copy_rounded,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Share this code to add members',
                        style: TextStyle(
                          color: royalYellow,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          //Invite Member
                        },
                        child: GradientButton(
                          buttonText: 'Invite',
                          firstColor: lightYellow,
                          secondColor: royalYellow,
                          showArrow: false,
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          //Leave Group

                          groupController.leaveGroup(group);
                          Navigator.pop(context);
                        },
                        child: BorderButton(
                          buttonText: 'Leave',
                          buttonColor: red,
                          borderRadius: 30,
                          buttonWidth: 160,
                        ),
                      ),
                    ],
                  ),
                )
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
