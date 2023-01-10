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
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          onIconClick: () {
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
              const SizedBox(
                height: 10,
              ),
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
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  if (_groupNameController.text.length > 3) {
                    groupController.createGroup(_groupNameController.text);
                    //should then dismiss the screen
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
