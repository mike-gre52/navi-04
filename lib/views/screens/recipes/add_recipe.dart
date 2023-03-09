import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/utils/scrapper.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _linkController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _linkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height20 = screenHeight / 44.8;
    double height25 = screenHeight / 35.84;
    double height30 = screenHeight / 29.86;
    double height60 = screenHeight / 14.933;
    double width10 = screenWidth / 41.4;
    double width30 = screenWidth / 13.8;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;
    double fontSize22 = screenHeight / 40.727;
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: width30, right: width30, top: height30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: width10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Add Recipe link:',
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
            CustomTextfield(
              icon: CupertinoIcons.link,
              placeholderText: 'recipe link',
              controller: _linkController,
              borderColor: appBlue,
              textfieldWidth: double.maxFinite,
              textfieldHeight: height60,
              borderRadius: height10,
              onSubmit: (_) {},
              onChanged: (_) {},
            ),
            SizedBox(height: height20),
            GestureDetector(
              onTap: () async {
                Get.toNamed(RouteHelper.getLoadingScreen());
                Navigator.pop(context);
                try {
                  dynamic recipeData =
                      await getWebsiteData(_linkController.text);

                  // Get.toNamed(RouteHelper.getConfirmImportRecipe(),
                  //     arguments: [recipeData, _linkController.text]);

                  dynamic jsonData;

                  late String recipeName;
                  late int cookTime;
                  late int prepTime;
                  late int totalTime;
                  late String recipeYield;
                  late List<Ingredient> recipeIngredients;
                  late List<Instruction> recipeInstructions;
                  late String sourceUrl;
                  late String imageUrl;

                  jsonData = recipeData;
                  sourceUrl = _linkController.text;
                  int index = findData(jsonData);
                  recipeName = getRecipeName(jsonData, index);
                  imageUrl = getRecipeImage(jsonData, index);
                  prepTime = getPrepTime(jsonData, index);
                  cookTime = getCookTime(jsonData, index);
                  totalTime = getTotalTime(jsonData, index);
                  recipeYield = getRecipeYield(jsonData, index);
                  recipeInstructions = getRecipeInstructions(jsonData, index);
                  recipeIngredients = getRecipeIngredients(jsonData, index);

                  Recipe recipe = Recipe(
                    name: recipeName,
                    prepTime: prepTime,
                    cookTime: cookTime,
                    totalTime:
                        totalTime == -1 ? prepTime + cookTime : totalTime,
                    servings: recipeYield,
                    id: generateId(),
                    imageUrl: imageUrl,
                    ingredients: recipeIngredients,
                    instructions: recipeInstructions,
                    sourceUrl: sourceUrl,
                    isLink: false,
                    isImport: true,
                  );

                  recipeController.uploadRecipe(recipe);

                  // prompt add ingredients screen.......
                  Navigator.pop(context);
                  Get.toNamed(RouteHelper.getImportedRecipe(),
                      arguments: recipe);
                  //Get.toNamed(RouteHelper.recipeScreen, arguments: recipe);
                } catch (e) {
                  print(e);
                  Get.toNamed(RouteHelper.getBookmarkList(),
                      arguments: _linkController.text);
                }
              },
              child: BorderButton(
                buttonColor: appBlue,
                buttonText: 'Add',
              ),
            ),
            SizedBox(height: height25),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Want to create a recipe from scratch?',
                style: TextStyle(fontSize: fontSize20),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(RouteHelper.getCreateRecipeScreen());
              },
              child: Text(
                'Click Here',
                style: TextStyle(
                    color: appBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize22),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
