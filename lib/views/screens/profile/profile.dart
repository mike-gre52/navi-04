import 'package:flutter/material.dart';
import 'package:whats_for_dinner/data/local_data.dart';

import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/header.dart';
import 'package:whats_for_dinner/views/widgets/profile/circle_check_button.dart';
import 'package:whats_for_dinner/views/widgets/profile/join_group.dart';
import 'package:whats_for_dinner/views/widgets/profile/select_color.dart';

import '../../../models/user.dart';
import '../../widgets/app_header.dart';

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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextfield(
                            icon: Icons.person,
                            placeholderText: '',
                            controller: _nameController,
                            borderColor: royalYellow,
                            textfieldWidth: 280,
                            textfieldHeight: 60,
                            borderRadius: 25,
                          ),
                          GestureDetector(
                            onTap: () async {
                              print(await Database().getColor());
                            },
                            child: CircleCheckButton(),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      JoinGroup(
                        inGroup: data.inGroup,
                        username: data.name,
                        userColor: data.color,
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
