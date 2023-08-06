import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _groupNameController = TextEditingController();

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
    double height10 = screenHeight / 89.6;
    double height20 = screenHeight / 44.8;
    double height40 = screenHeight / 22.4;
    double height60 = screenHeight / 14.933;
    double width5 = screenWidth / 82.8;
    double width30 = screenWidth / 13.8;
    double fontSize18 = screenHeight / 49.777;

    List data = Get.arguments as List;
    Function onCreateGroup = data[0];

    return Scaffold(
        body: Column(
      children: [
        AppHeader(
          headerText: 'Create Group',
          headerColor: Colors.white,
          borderColor: royalYellow,
          textColor: black,
          dividerColor: royalYellow,
          rightAction: Text(
            'Cancel',
            style: TextStyle(
              color: black,
              fontSize: height20,
              fontWeight: FontWeight.w500,
            ),
          ),
          onIconClick: () {
            Navigator.pop(context);
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
              SizedBox(
                height: height10,
              ),
              Container(
                margin: EdgeInsets.only(left: width5),
                child: Text(
                  'Group Name',
                  style: TextStyle(
                    fontSize: fontSize18,
                    color: black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CustomTextfield(
                icon: Icons.groups_rounded,
                placeholderText: '',
                controller: _groupNameController,
                borderColor: royalYellow,
                textfieldWidth: double.maxFinite,
                textfieldHeight: height60,
                borderRadius: height10,
                onSubmit: (_) {},
                onChanged: (_) {},
              ),
              SizedBox(
                height: height40,
              ),
              GestureDetector(
                onTap: () async {
                  if (_groupNameController.text.length > 3) {
                    await groupController
                        .createGroup(_groupNameController.text);
                    //should then dismiss the screen
                    onCreateGroup();
                    Navigator.pop(context);
                  } else {
                    Get.snackbar(
                      'Not a valid name',
                      'Please enter at least 4 charecters',
                    );
                  }
                },
                child: GradientButton(
                  buttonText: 'Create',
                  firstColor: lightYellow,
                  secondColor: royalYellow,
                  showArrow: false,
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
