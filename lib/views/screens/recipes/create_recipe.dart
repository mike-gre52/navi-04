import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_for_dinner/controllers/image_controller.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/app/gradient_button.dart';
import 'package:whats_for_dinner/views/widgets/app/text_header.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_ingredients.dart';
import 'package:whats_for_dinner/views/widgets/recipes/recipe_instructions.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/notes_textfield.dart';

import '../../../models/recipe.dart';
import '../../widgets/app/app_header.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({Key? key}) : super(key: key);

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipePrepTimeController =
      TextEditingController();
  final TextEditingController _recipeCookTimeController =
      TextEditingController();
  final TextEditingController _recipeServingsController =
      TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _instructionController = TextEditingController();
  final TextEditingController _measurementController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  int ingredientCounter = 0;
  int instructionCounter = 0;
  List<Ingredient> recipeIngredients = [];
  List<Instruction> recipeInstructions = [];
  ImageController imageController = ImageController();
  bool isImageSelected = false;
  bool showTimeError = false;
  bool showAmountError = false;
  bool isformValid = true;
  bool isLoading = false;

  void setImageStatus() {
    setState(() {
      isImageSelected = true;
    });
  }

  void checkTimeInput(input) {
    if (input != null) {
      if (input == '') {
        setState(() {
          showTimeError = false;
        });
      } else {
        double? num = double.tryParse(input);
        if (num != null) {
          setState(() {
            showTimeError = false;
          });
        } else {
          setState(() {
            showTimeError = true;
          });
        }
      }
    }
  }

  void checkAmountInput(input) {
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

  bool validateSubmit() {
    if (!showAmountError &&
        !showAmountError &&
        _recipeNameController.text != '' &&
        _recipePrepTimeController.text != '' &&
        _recipeCookTimeController.text != '' &&
        _recipeServingsController.text != '') {
      setState(() {
        isformValid = true;
      });

      return true;
    } else {
      setState(() {
        isformValid = false;
      });
      return false;
    }
  }

  void deleteIngredient(index) {
    setState(() {
      recipeIngredients.removeAt(index);
      ingredientCounter = 0;
    });
  }

  void deleteInstruction(index) {
    setState(() {
      recipeInstructions.removeAt(index);
      instructionCounter = 0;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _recipeNameController.dispose();
    _amountController.dispose();
    _ingredientController.dispose();
    _instructionController.dispose();
    _measurementController.dispose();
    _recipeCookTimeController.dispose();
    _recipePrepTimeController.dispose();
    _recipeServingsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBlue,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                //top nav
                AppHeader(
                  headerText: 'Add Recipes',
                  headerColor: appBlue,
                  borderColor: royalYellow,
                  textColor: Colors.white,
                  dividerColor: Colors.white,
                  safeArea: true,
                  rightAction: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onIconClick: () {
                    Navigator.pop(context);
                  },
                ),
                //Column under nav
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      //Recipe Name
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: HeaderAndTextField(
                            header: 'Name:',
                            controller: _recipeNameController,
                            width: double.maxFinite,
                            leftAlign: true,
                            placeHolderText: '',
                            useTextKeyboard: true,
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      //Select Image Row
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showActionSheet(
                                    context, imageController, setImageStatus);
                              },
                              child: isImageSelected
                                  ? Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.file(
                                          imageController.image!,
                                          height: 150.0,
                                          width: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey,
                                      ),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 35,
                                        color: appBlue,
                                      ),
                                    ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                // pick photo
                                //_showDialog(context);
                                _showActionSheet(
                                    context, imageController, setImageStatus);
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'IBMPlexSansDevanagari'),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Click Here',
                                      style: TextStyle(color: appBlue),
                                    ),
                                    const TextSpan(text: ' to add a image')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      //Prep, Cook, Servings Row
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeaderAndTextField(
                                  header: 'Prep Time',
                                  controller: _recipePrepTimeController,
                                  width: 75,
                                  placeHolderText: '',
                                  onChanged: checkTimeInput,
                                  centerText: true,
                                ),
                                HeaderAndTextField(
                                  header: 'Cook Time',
                                  controller: _recipeCookTimeController,
                                  width: 75,
                                  placeHolderText: '',
                                  onChanged: checkTimeInput,
                                  centerText: true,
                                ),
                                HeaderAndTextField(
                                  header: 'Servings',
                                  controller: _recipeServingsController,
                                  width: 75,
                                  placeHolderText: '',
                                  onChanged: (_) {},
                                  centerText: true,
                                ),
                              ],
                            ),
                            showTimeError
                                ? Container(
                                    height: 25,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Input must be a valid number',
                                      style: TextStyle(
                                        color: red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 25,
                                  ),
                          ],
                        ),
                      ),
                      //Ingredients tab
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextHeader(
                            text: 'Ingredients:',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //Ingredient Name
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                HeaderAndTextField(
                                  header: 'Amount',
                                  controller: _amountController,
                                  width: 75,
                                  placeHolderText: '',
                                  onChanged: checkAmountInput,
                                  subText: 'Ex: 2, 0.5',
                                  showSubText: true,
                                  centerText: true,
                                ),
                                HeaderAndTextField(
                                  header: 'Name',
                                  controller: _ingredientController,
                                  width: 200,
                                  leftAlign: true,
                                  placeHolderText: '',
                                  useTextKeyboard: true,
                                  onChanged: (_) {},
                                  subText: 'Ex: cups flour, tbs salt',
                                  showSubText: true,
                                ),
                                SizedBox(
                                  height: 50,
                                  child: GestureDetector(
                                    onTap: () {
                                      //
                                      setState(() {
                                        if (_ingredientController.text != '' &&
                                            _amountController.text != '') {
                                          ingredientCounter++;
                                          String instruction =
                                              _amountController.text +
                                                  _measurementController.text +
                                                  _instructionController.text;

                                          Ingredient ingredient = Ingredient(
                                            name: _ingredientController.text,
                                            amount: double.parse(
                                                _amountController.text),
                                            id: generateId(),
                                          );
                                          recipeIngredients.add(ingredient);
                                          _ingredientController.clear();
                                          _measurementController.clear();
                                          _amountController.clear();
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: appBlue,
                                      size: 40,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            showAmountError
                                ? Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    height: 20,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Amount must be a valid number',
                                      style: TextStyle(
                                        color: red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 30,
                                  ),
                          ],
                        ),
                      ),
                      //Ingredients Scroll View
                      Container(
                        height: 200,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 3.0, color: appBlue),
                            bottom: BorderSide(width: 3.0, color: appBlue),
                          ),
                          color: backgroundGrey,
                        ),
                        child: RecipeIngredientList(
                          ingredients: recipeIngredients,
                          showDelete: true,
                          deleteIngredient: deleteIngredient,
                        ),
                      ),
                      //Instructions tab
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextHeader(
                              text: 'Instructions:',
                              fontSize: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                //Add instruction
                                setState(() {
                                  if (_instructionController.text != '') {
                                    instructionCounter++;
                                    Instruction instruction = Instruction(
                                      instruction: _instructionController.text,
                                      id: generateId(),
                                      orderNumber: instructionCounter,
                                    );
                                    recipeInstructions.add(instruction);
                                    _instructionController.clear();
                                  }
                                });
                              },
                              child: Icon(
                                Icons.add_rounded,
                                color: appBlue,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                      ),
                      //Instructions textfield
                      NotesTextfield(
                        controller: _instructionController,
                        borderColor: appBlue,
                        height: 150,
                      ),
                      const SizedBox(height: 10),
                      //Instruction Scroll View
                      Container(
                          height: 200,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 3.0, color: appBlue),
                              bottom: BorderSide(width: 3.0, color: appBlue),
                            ),
                            color: backgroundGrey,
                          ),
                          child: RecipeInstructionList(
                            instructions: recipeInstructions,
                            showDelete: true,
                            deleteInstruction: deleteInstruction,
                          )),
                      const SizedBox(height: 20),
                      Container(
                        height: 20,
                        child: isLoading
                            ? CupertinoActivityIndicator(
                                radius: 15,
                                color: appBlue,
                                animating: true,
                              )
                            : null,
                      ),

                      const SizedBox(height: 20),
                      //Submit Button
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (validateSubmit()) {
                                setState(() {
                                  isLoading = true;
                                });
                                String url = '';
                                String recipeId = generateId();
                                if (isImageSelected) {
                                  Reference ref = firebaseStorage
                                      .ref()
                                      .child(globalGroupId)
                                      .child('recipeImages')
                                      .child(recipeId);

                                  url = await imageController.uploadToStorage(
                                      imageController.image!, ref);
                                }
                                int prepTime =
                                    int.parse(_recipePrepTimeController.text);
                                int cookTime =
                                    int.parse(_recipeCookTimeController.text);
                                Recipe recipe = Recipe(
                                  name: _recipeNameController.text,
                                  prepTime:
                                      int.parse(_recipePrepTimeController.text),
                                  cookTime:
                                      int.parse(_recipeCookTimeController.text),
                                  totalTime: prepTime + cookTime,
                                  servings: _recipeServingsController.text,
                                  id: recipeId,
                                  imageUrl: url,
                                  ingredients: recipeIngredients,
                                  instructions: recipeInstructions,
                                  sourceUrl: '',
                                  isLink: false,
                                  isImport: false,
                                );

                                // call upload function in recipe controller
                                recipeController.uploadRecipe(recipe);

                                setState(() {
                                  isLoading = false;
                                });

                                Navigator.pop(context);
                              }
                            },
                            child: GradientButton(
                              buttonText: 'Add',
                              firstColor: lightBlue,
                              secondColor: appBlue,
                            ),
                          ),
                          isformValid
                              ? Container(
                                  height: 25,
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  height: 20,
                                  child: Text(
                                    'Input is invalid',
                                    style: TextStyle(
                                      color: red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class HeaderAndTextField extends StatelessWidget {
  String header;
  TextEditingController controller;
  double width;
  bool leftAlign;
  String placeHolderText;
  bool useTextKeyboard;
  void Function(String?) onChanged;
  String subText;
  bool showSubText;
  bool centerText;

  HeaderAndTextField({
    Key? key,
    required this.header,
    required this.controller,
    required this.width,
    required this.placeHolderText,
    required this.onChanged,
    this.leftAlign = false,
    this.useTextKeyboard = false,
    this.subText = '',
    this.showSubText = false,
    this.centerText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        CustomTextfield(
          icon: Icons.abc,
          placeholderText: placeHolderText,
          controller: controller,
          borderColor: appBlue,
          textfieldWidth: width,
          textfieldHeight: 50,
          keyboard: useTextKeyboard
              ? TextInputType.text
              : const TextInputType.numberWithOptions(decimal: true),
          borderRadius: 10,
          showIcon: false,
          onSubmit: (_) {},
          onChanged: onChanged,
          centerText: centerText,
        ),
        showSubText
            ? Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  subText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

void _showActionSheet(BuildContext context, ImageController imageController,
    Function setImageStatus) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// defualt behavior, turns the action's text to bold text.
          onPressed: () {
            //Open Library
            imageController.pickImage(
              false,
              setImageStatus,
            );
            Navigator.pop(context);
          },
          child: const Text('Choose from library'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            //Open Camera
            imageController.pickImage(true, setImageStatus);
            Navigator.pop(context);
          },
          child: const Text('Take photo'),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
