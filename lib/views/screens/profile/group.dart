import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/group.dart';

import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';
import 'package:whats_for_dinner/views/widgets/app/header.dart';
import 'package:whats_for_dinner/views/widgets/profile/circle_check_button.dart';
import 'package:whats_for_dinner/views/widgets/profile/group_members.dart';
import 'package:whats_for_dinner/views/widgets/profile/join_group.dart';
import 'package:whats_for_dinner/views/widgets/profile/select_color.dart';

import '../../../models/user.dart';
import '../../widgets/app/app_header.dart';

class GroupScreen extends StatefulWidget {
  GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  TextEditingController _groupNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height20 = screenHeight / 44.8;
    double height40 = screenHeight / 22.4;
    double width10 = screenWidth / 41.4;
    double width30 = screenWidth / 13.8;
    double width200 = screenWidth / 2.07;
    double fontSize14 = screenHeight / 64;
    double fontSize16 = screenHeight / 56;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;
    double fontSize22 = screenHeight / 40.727;
    return inGroup
        ? Scaffold(
            body: StreamBuilder<Group>(
              stream: groupController.getGroupData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final Group group = snapshot.data!;
                  _groupNameController.text = group.groupName;
                  return Column(
                    children: [
                      AppHeader(
                        headerText: group.groupName.length <= 12
                            ? group.groupName[0].toUpperCase() +
                                group.groupName.substring(1)
                            : "${group.groupName[0].toUpperCase()}${group.groupName.substring(1, 12)}...",
                        headerColor: Colors.white,
                        borderColor: royalYellow,
                        textColor: black,
                        dividerColor: royalYellow,
                        rightAction: Container(
                          margin: EdgeInsets.only(bottom: height10),
                          child: const Icon(Icons.settings),
                        ),
                        onIconClick: () {
                          Get.toNamed(RouteHelper.getProfileRoute());
                        },
                      ),
                      SizedBox(
                        height: height20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                        fontSize: fontSize16,
                                        fontWeight: FontWeight.w400,
                                        color: royalYellow),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: height20),
                            const GroupMembers(),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.selectColor);
                              },
                              child: Text(
                                'Edit Color',
                                style: TextStyle(
                                    fontSize: fontSize16,
                                    fontWeight: FontWeight.w400,
                                    color: royalYellow),
                              ),
                            ),
                            SizedBox(height: height20),
                            Header(
                                headerText: 'Group Code',
                                dividerColor: royalYellow),
                            SizedBox(height: height10),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width10, vertical: height5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(height10),
                                color: royalYellow.withAlpha(75),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    group.groupId,
                                    style: TextStyle(
                                      color: black,
                                      fontSize: fontSize20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (() {
                                      Clipboard.setData(
                                          ClipboardData(text: group.groupId));

                                      Get.snackbar(
                                        "",
                                        "",
                                        maxWidth: width200,
                                        padding: EdgeInsets.all(height5),
                                        titleText: Center(
                                          child: Text(
                                            "Group code copied",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSize18),
                                          ),
                                        ),
                                      );
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
                                fontSize: fontSize14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: height20),
                            GestureDetector(
                              onTap: () {
                                //Invite Member
                                Share.share(" $appUrl" +
                                    "\n" +
                                    "Download Whats for Dinner? and join our group with the code ${group.groupId}");
                              },
                              child: GradientButton(
                                buttonText: 'Invite',
                                firstColor: lightYellow,
                                secondColor: royalYellow,
                                showArrow: false,
                              ),
                            ),
                            SizedBox(height: height40),
                            GestureDetector(
                              onTap: () {
                                //Leave Group
                                groupController.leaveGroup(group);
                                setState(() {
                                  inGroup = false;
                                });
                              },
                              child: Text(
                                "Leave Group",
                                style: TextStyle(
                                  color: darkRed,
                                  fontSize: fontSize22,
                                ),
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
          )
        : StreamBuilder<User>(
            stream: userController.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Column(
                  children: [
                    AppHeader(
                      headerText: 'Profile',
                      headerColor: Colors.white,
                      borderColor: royalYellow,
                      textColor: black,
                      dividerColor: royalYellow,
                      rightAction: Container(),
                      onIconClick: () {},
                    ),
                    SizedBox(
                      height: height20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width30, vertical: height5),
                      child: JoinGroup(
                        inGroup: data.inGroup,
                        username: data.name,
                        userColor: data.color,
                        onSubmit: () {
                          setState(() {
                            inGroup = true;
                          });
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            });
  }
}
    /* 
    return Scaffold(
      body: StreamBuilder<User>(
        stream: userController.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            _nameController.text = data.name;
            return Column(
              children: [
                AppHeader(
                  headerText: 'Profile',
                  headerColor: Colors.white,
                  borderColor: royalYellow,
                  textColor: black,
                  dividerColor: royalYellow,
                  rightAction: Container(),
                  onIconClick: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileRow(name: data.name, icon: Icons.person_rounded),
                        const SizedBox(height: 10),
                        ProfileRow(name: data.email, icon: CupertinoIcons.mail),
                        const SizedBox(height: 18),
                        JoinGroup(
                          inGroup: data.inGroup,
                          username: data.name,
                          userColor: data.color,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            authController.signOut();
                          },
                          child: Text(
                            "Sign Out",
                            style: TextStyle(color: darkRed, fontSize: 22),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "v1.0.18",
                            style: TextStyle(color: darkGrey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
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

class ProfileRow extends StatelessWidget {
  String name;
  IconData icon;
  ProfileRow({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 28,
          color: royalYellow,
        ),
        const SizedBox(width: 20),
        Text(
          name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
        )
      ],
    );
  }
}

 //ProfileRow(name: data.name, icon: Icons.person_rounded),
 //const SizedBox(height: 10),
 //ProfileRow(name: data.email, icon: CupertinoIcons.mail),
 //const SizedBox(height: 18),


*/