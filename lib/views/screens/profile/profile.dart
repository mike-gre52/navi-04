import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/group.dart';
import 'package:whats_for_dinner/models/user.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/app_yes_no_popup.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';
import 'package:whats_for_dinner/views/widgets/app/header.dart';
import 'package:whats_for_dinner/views/widgets/profile/group_member.dart';
import 'package:whats_for_dinner/views/widgets/home/home_header.dart';
import 'package:whats_for_dinner/views/widgets/profile/group_members.dart';
import 'package:whats_for_dinner/views/widgets/profile/join_group.dart';
import 'package:whats_for_dinner/views/widgets/profile/select_color.dart';

import '../../widgets/app/rounded_corner_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _groupNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _groupNameController.dispose();
  }

  _showRateAppDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Are you enjoying the app?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              LaunchReview.launch(iOSAppId: "1639923197");
            },
          ),
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
              launchEmail();
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  launchEmail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'souchefapp.help@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'Subject': 'Souchef App Help',
      }),
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      launchUrl(emailLaunchUri);
    }
  }

  _signOutDialog(BuildContext context) {
    void _onRightAction() {
      Navigator.pop(context);
      authController.signOut();
    }

    showDialog(
      context: context,
      builder: (_) => AppYesNoPopup(
        header: 'Are you sure you want to sign out?',
        subHeader: "",
        leftActionButton: "Yes",
        rightActionButton: "No",
        leftActionFunction: _onRightAction,
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height20 = screenHeight / 44.8;
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double height65 = screenHeight / 13.784;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;
    double fontSize35 = screenHeight / 25.6;
    double height205 = screenHeight / 4.3707;
    double width10 = screenWidth / 41.4;
    double width30 = screenWidth / 13.8;
    double width80 = screenWidth / 5.175;
    double width200 = screenWidth / 2.07;
    double width350 = screenWidth / 1.182;
    double fontSize14 = screenHeight / 64;
    double fontSize16 = screenHeight / 56;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;
    double fontSize22 = screenHeight / 40.727;

    return Scaffold(
      body: StreamBuilder<User>(
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
                  rightAction: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onIconClick: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: height20,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: width30, vertical: height5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileRow(
                          name: data.name,
                          icon: Icons.person_rounded,
                        ),
                        SizedBox(height: height10),
                        ProfileRow(
                          name: data.email,
                          icon: CupertinoIcons.mail,
                        ),
                        SizedBox(height: height20),
                        const CurrentPlan(),
                        SizedBox(height: height20),
                        Align(
                          alignment: Alignment.center,
                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [royalYellow, lightYellow],
                            ).createShader(bounds),
                            child: Text(
                              'Premium Plan coming soon!',
                              style: TextStyle(
                                fontSize: fontSize22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Share.share(
                                    " $appUrl " +
                                        " Download the Souchef Meal Planner App!",
                                    subject: "Download Souchef");
                              },
                              child: const RoundedCornerButton(
                                icon: Icons.share_rounded,
                                text: "Share",
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                _showRateAppDialog(context);
                              },
                              child: const RoundedCornerButton(
                                icon: Icons.star_rounded,
                                text: "Rate",
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            _signOutDialog(context);
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
                ),
                Container(height: height40),
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

class CurrentPlan extends StatelessWidget {
  const CurrentPlan({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double width10 = screenWidth / 41.4;
    double width40 = screenWidth / 10.35;
    double width100 = screenWidth / 4.14;
    double height10 = screenHeight / 89.6;
    double height50 = screenHeight / 17.92;
    double fontSize20 = screenHeight / 44.8;
    double fontSize22 = screenHeight / 40.727;

    return Row(
      children: [
        Text(
          "Current Plan:",
          style: TextStyle(
            fontSize: fontSize22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: width10),
        isPremium
            ? ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [royalYellow, lightYellow],
                ).createShader(bounds),
                child: Text(
                  'Premium',
                  style: TextStyle(
                    fontSize: fontSize22,
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
                children: [
                  Text(
                    "Free",
                    style: TextStyle(
                      fontSize: fontSize22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: width40),
                  /*
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getPremiumUpgradeScreen());
                    },
                    child: Container(
                      height: height50,
                      width: width100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          height10,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: const [0, 1],
                          colors: [royalYellow, lightYellow],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Upgrade",
                          style: TextStyle(
                            fontSize: fontSize20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  */
                ],
              ),
      ],
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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height30 = screenHeight / 29.86;
    double width20 = screenWidth / 20.7;
    double fontSize22 = screenHeight / 40.727;

    return Row(
      children: [
        Icon(
          icon,
          size: height30,
          color: royalYellow,
        ),
        SizedBox(width: width20),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontSize: fontSize22,
              fontWeight: FontWeight.w200,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}
