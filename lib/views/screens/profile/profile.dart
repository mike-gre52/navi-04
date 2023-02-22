import 'package:flutter/material.dart';
import 'package:whats_for_dinner/data/local_data.dart';

import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/app/header.dart';
import 'package:whats_for_dinner/views/widgets/profile/circle_check_button.dart';
import 'package:whats_for_dinner/views/widgets/profile/join_group.dart';
import 'package:whats_for_dinner/views/widgets/profile/select_color.dart';

import '../../../models/user.dart';
import '../../widgets/app/app_header.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
