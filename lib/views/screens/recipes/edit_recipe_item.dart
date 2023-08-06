import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/notes_textfield.dart';

class EditRecipeItemScreen extends StatefulWidget {
  const EditRecipeItemScreen({Key? key}) : super(key: key);

  @override
  State<EditRecipeItemScreen> createState() => _EditRecipeItemScreenState();
}

class _EditRecipeItemScreenState extends State<EditRecipeItemScreen> {
  final TextEditingController _contentTextController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _contentTextController.dispose();
  }

  bool showAmountError = false;

  void validateDoubleInput(input) {
    if (input != null) {
      if (input == '') {
        setState(() {
          showAmountError = false;
        });
      } else {
        double? num = double.tryParse(input);
        if (num != null) {
          setState(() {
            showAmountError = false;
          });
        } else {
          setState(() {
            showAmountError = true;
          });
        }
      }
    }
  }

  final data = Get.arguments as List;
  late String dataType;
  late Ingredient ingredient;
  late Instruction instruction;
  late int index;
  late Function editIngredient;
  late Function addIngredient;
  late Function editInstruction;
  late Function addInstruction;
  late bool newItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataType = data[0] as String;
    if (dataType == 'Ingredient') {
      ingredient = data[1] as Ingredient;

      _contentTextController.text = ingredient.name;
      editIngredient = data[3] as Function;
      addIngredient = data[4] as Function;
    } else {
      instruction = data[1] as Instruction;
      _contentTextController.text = instruction.instruction;
      editInstruction = data[3] as Function;
      addInstruction = data[4] as Function;
    }

    index = data[2] - 1;
    newItem = data[5] as bool;
  }

  void onSubmit() {
    if (_contentTextController.text != '' && !showAmountError) {
      if (dataType == 'Ingredient') {
        Ingredient newIngredient = Ingredient(
          name: _contentTextController.text,
          id: ingredient.id,
        );
        newItem
            ? addIngredient(newIngredient)
            : editIngredient(newIngredient, index);
      } else {
        //Instruction

        Instruction newInstruction = Instruction(
          instruction: _contentTextController.text,
          id: instruction.id,
          orderNumber: instruction.orderNumber,
        );

        newItem
            ? addInstruction(newInstruction)
            : editInstruction(newInstruction, index);
      }
      Navigator.pop(context);
    }
  }

  void onDismiss(String? s) {
    print("dimiss keyboard");
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height20 = screenHeight / 44.8;
    double height25 = screenHeight / 35.84;
    double height30 = screenHeight / 29.86;
    double height60 = screenHeight / 14.933;
    double height200 = screenHeight / 4.48;
    double width10 = screenWidth / 41.4;
    double width30 = screenWidth / 13.8;
    double width150 = screenWidth / 2.76;
    double fontSize18 = screenHeight / 49.777;
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: width30, right: width30, top: height30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: width10, right: width10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Edit $dataType:',
                      style: TextStyle(
                        fontSize: fontSize18,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: fontSize18,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height15),
            dataType == 'Ingredient'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextfield(
                          icon: Icons.bookmark_outline,
                          placeholderText: 'Item',
                          controller: _contentTextController,
                          borderColor: appBlue,
                          textfieldWidth: double.maxFinite,
                          textfieldHeight: height60,
                          borderRadius: height10,
                          showIcon: false,
                          onSubmit: (_) {},
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: NotesTextfield(
                      controller: _contentTextController,
                      borderColor: appBlue,
                      height: height200,
                      onDismiss: onDismiss,
                    ),
                  ),
            showAmountError
                ? Container(
                    margin: EdgeInsets.only(top: height5),
                    height: height20,
                    alignment: Alignment.center,
                    child: Text(
                      'Amount must be a valid number',
                      style: TextStyle(
                        color: red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Container(
                    height: height25,
                  ),
            SizedBox(height: height10),
            GestureDetector(
              onTap: () {
                onSubmit();
              },
              child: BorderButton(
                buttonColor: appBlue,
                buttonText: 'Submit',
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
