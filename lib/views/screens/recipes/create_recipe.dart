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

  void addIngredient(String? ingredient) {
    setState(() {
      if (_ingredientController.text != '') {
        ingredientCounter++;

        Ingredient ingredient = Ingredient(
          name: _ingredientController.text,
          id: generateId(),
        );
        recipeIngredients.add(ingredient);
        _ingredientController.clear();
      }
    });
  }

  void addInstruction(String? ingredient) {
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _recipeNameController.dispose();
    _ingredientController.dispose();
    _instructionController.dispose();

    _recipeCookTimeController.dispose();
    _recipePrepTimeController.dispose();
    _recipeServingsController.dispose();
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
    double height35 = screenHeight / 25.6;
    double height40 = screenHeight / 22.4;
    double height50 = screenHeight / 17.92;
    double height75 = screenHeight / 11.946;
    double height150 = screenHeight / 5.973;
    double height200 = screenHeight / 4.48;
    double width25 = screenWidth / 16.56;
    double width35 = screenWidth / 11.828;
    double width75 = screenWidth / 5.52;
    double width100 = screenWidth / 4.14;
    double width200 = screenWidth / 2.07;
    double fontSize20 = screenHeight / 44.8;
    double fontSize16 = screenHeight / 74.66;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: appBlue,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    rightAction: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onIconClick: () {
                      Navigator.pop(context);
                    },
                  ),
                  //Column under nav
                  Container(
                    margin: EdgeInsets.only(top: height10),
                    child: Column(
                      children: [
                        //Recipe Name
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: height25),
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
                              onDismiss: addIngredient,
                            ),
                          ),
                        ),
                        SizedBox(height: height10),
                        //Select Image Row
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width25),
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
                                        height: height75,
                                        width: width75,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(height10),
                                          color: Colors.grey,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(height10),
                                          child: Image.file(
                                            imageController.image!,
                                            height: height150,
                                            width: width100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: height75,
                                        width: width75,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey,
                                        ),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: height35,
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
                                    style: TextStyle(
                                        fontSize: fontSize20,
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
                        SizedBox(height: height10),
                        //Prep, Cook, Servings Row
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: height25),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  HeaderAndTextField(
                                    header: 'Prep Time',
                                    controller: _recipePrepTimeController,
                                    width: width75,
                                    placeHolderText: '',
                                    onChanged: checkTimeInput,
                                    centerText: true,
                                    onDismiss: addIngredient,
                                  ),
                                  HeaderAndTextField(
                                    header: 'Cook Time',
                                    controller: _recipeCookTimeController,
                                    width: width75,
                                    placeHolderText: '',
                                    onChanged: checkTimeInput,
                                    centerText: true,
                                    onDismiss: addIngredient,
                                  ),
                                  HeaderAndTextField(
                                    header: 'Servings',
                                    controller: _recipeServingsController,
                                    width: width75,
                                    placeHolderText: '',
                                    onChanged: (_) {},
                                    centerText: true,
                                    onDismiss: addIngredient,
                                  ),
                                ],
                              ),
                              showTimeError
                                  ? Container(
                                      height: height25,
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
                                      height: height25,
                                    ),
                            ],
                          ),
                        ),
                        //Ingredients tab
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width25),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextHeader(
                              text: 'Ingredients:',
                              fontSize: fontSize20,
                            ),
                          ),
                        ),
                        //Ingredient Name
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width25),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  HeaderAndTextField(
                                    header: 'Add ingredients',
                                    controller: _ingredientController,
                                    width: width200,
                                    leftAlign: true,
                                    placeHolderText: '',
                                    useTextKeyboard: true,
                                    onChanged: (_) {},
                                    showSubText: true,
                                    onDismiss: addIngredient,
                                  ),
                                  Expanded(child: Container()),
                                  SizedBox(
                                    height: height50,
                                    child: GestureDetector(
                                      onTap: () {
                                        //
                                        addIngredient("");
                                      },
                                      child: Icon(
                                        Icons.add_rounded,
                                        color: appBlue,
                                        size: height40,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              showAmountError
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: height5),
                                      height: height20,
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
                                      height: height30,
                                    ),
                            ],
                          ),
                        ),
                        //Ingredients Scroll View
                        Container(
                          height: height200,
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
                          margin: EdgeInsets.symmetric(horizontal: width35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextHeader(
                                text: 'Instructions:',
                                fontSize: fontSize20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  //Add instruction
                                  addInstruction("");
                                },
                                child: Icon(
                                  Icons.add_rounded,
                                  color: appBlue,
                                  size: height40,
                                ),
                              )
                            ],
                          ),
                        ),
                        //Instructions textfield
                        NotesTextfield(
                          controller: _instructionController,
                          borderColor: appBlue,
                          height: height150,
                          onDismiss: addInstruction,
                        ),
                        SizedBox(height: height10),
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
                        SizedBox(height: height20),
                        Container(
                          height: height20,
                          child: isLoading
                              ? CupertinoActivityIndicator(
                                  radius: height15,
                                  color: appBlue,
                                  animating: true,
                                )
                              : null,
                        ),

                        SizedBox(height: height20),
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
                                    prepTime: int.parse(
                                        _recipePrepTimeController.text),
                                    cookTime: int.parse(
                                        _recipeCookTimeController.text),
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
                                    height: height25,
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.symmetric(vertical: height5),
                                    height: height20,
                                    child: Text(
                                      'Name, Prep/Cook Time, and Servings must be entered ',
                                      style: TextStyle(
                                        fontSize: fontSize16,
                                        color: red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: height30),
                      ],
                    ),
                  )
                ],
              ),
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
  void Function(String?) onDismiss;

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
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height10 = screenHeight / 89.6;
    double height50 = screenHeight / 17.92;
    double width5 = screenWidth / 82.8;
    double fontSize14 = screenHeight / 64;
    double fontSize16 = screenHeight / 56;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
            fontSize: fontSize16,
            fontWeight: FontWeight.w700,
          ),
        ),
        CustomTextfield(
          icon: Icons.abc,
          placeholderText: placeHolderText,
          controller: controller,
          borderColor: appBlue,
          textfieldWidth: width,
          textfieldHeight: height50,
          keyboard: useTextKeyboard
              ? TextInputType.text
              : const TextInputType.numberWithOptions(
                  decimal: true,
                ),
          borderRadius: height10,
          showIcon: false,
          onSubmit: onDismiss,
          onChanged: onChanged,
          centerText: centerText,
        ),
        showSubText
            ? Container(
                margin: EdgeInsets.only(left: width5),
                child: Text(
                  subText,
                  style: TextStyle(
                    fontSize: fontSize14,
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
