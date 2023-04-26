import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:whats_for_dinner/models/recipe.dart';
import 'package:whats_for_dinner/utils/helper.dart';

dynamic getWebsiteData(String uri) async {
  final url = Uri.parse(uri);
  final response = await http.get(url);

  dynamic finalData = '';

  //print(response.body);
  int headerIndex = 0;
  if (response.body.contains('type="application/ld+json"') == true) {
    headerIndex = response.body.indexOf('type="application/ld+json"');
  } else {
    headerIndex = response.body.indexOf('type=application/ld+json');
  }

  while (response.body.contains('type="application/ld+json"') &&
      finalData != null) {
    String response = "";
    int index = response.indexOf('type="application/ld+json"');
    String data = response.substring(index + 1);
    int nextIndex = response.indexOf('type="application/ld+json"');
  }

  String parse = response.body.substring(headerIndex);
  //print('--------------------------');

  int start = parse.indexOf('>');

  final jsonStart = parse.substring(start + 1);

  int end = jsonStart.indexOf('</script>');

  parse = jsonStart.substring(0, end);

  //print(parse);

  //removes links
  //while (parse.contains('<a href')) {
  //  int start = parse.indexOf('<a href');
  //  int end = parse.indexOf('</a>') + 3;
  //
  //  parse = parse.substring(0, start) + parse.substring(end, parse.length);
  //}
  //print(parse);

  final data = parse;

  final finalJson = json.decode(data);

  if (finalJson.runtimeType == List) {
    //print("isList");
    for (var i = 0; i < finalJson.length; i++) {
      if (finalJson[i]['@type'].runtimeType == List) {
        for (var j = 0; i < finalJson[i]['@type'].length; i++) {
          if (finalJson[i]['@type'][j] == 'Recipe') {
            return finalJson[i];
          }
        }
      } else {
        if (finalJson[i]['@type'] == 'Recipe') {
          return finalJson[i];
        }
      }
    }
    for (var i = 0; i < finalJson.length; i++) {
      if (finalJson[i]['@context'] == 'https://schema.org/') {
        return finalJson[i];
      }
    }
  } else {
    if (finalJson['name'] == null) {
      //print('@graph......');
      //print(finalJson['@graph'].runtimeType);
      finalData = finalJson['@graph'];
    } else {
      finalData = finalJson;
    }
  }

  return finalData;

  /*
  print('Recipe Name:' + finalData['name'] + '\n');
  //print('Recipe Prep time:' + finalData['prepTime'] + '\n');
  //print('Recipe Cook Time:' + finalData['cookTime'] + '\n');
  //print('Recipe Yield:' + finalData['recipeYield'].toString() + '\n');
  print('Recipe Image:' + finalData['image'].toString() + '\n');
  print('Recipe Ingredient:' + finalData['recipeIngredient'].toString() + '\n');
  print('Recipe Instructions:' +
      finalData['recipeInstructions'].toString() +
      '\n');
  */
}

int findData(dynamic jsonData) {
  if (jsonData.runtimeType == List) {
    jsonData as List;

    for (var i = 0; i < jsonData.length; i++) {
      if (jsonData[i]['@type'] == 'Recipe' ||
          jsonData[i]['@type'] == ['Recipe']) {
        return i;
      }
    }
    for (var i = 0; i < jsonData.length; i++) {
      if (jsonData[i]['@context'] == 'https://schema.org/') {
        return i;
      }
    }
    return -2;
  } else {
    return -1;
  }
}

String getRecipeName(dynamic jsonData, int index) {
  //dont call func if index == -2
  print("getting name");
  print(" value:  ${jsonData}");
  if (index == -1) {
    return jsonData['name'];
  } else if (index == -2) {
    //jsonData is list
    int innerI = 0;
    for (var i = 0; i < jsonData.length; i++) {
      print("getting I");
      if (jsonData[i]['@type'] == 'Recipe' ||
          jsonData[i]['@type'] == ['Recipe']) {
        innerI = 0;
        break;
      }
    }
    return jsonData[innerI]['name'];
  } else {
    return jsonData[index]['name'];
  }
}

String getRecipeImage(dynamic jsonData, int index) {
  dynamic image;

  print("index = $index");

  //dont call func if index == -2
  if (index == -1) {
    if (jsonData['image'].runtimeType == List) {
      if (jsonData['image'][0].runtimeType == String) {
        return jsonData['image'][0];
      } else if (jsonData['image'][0]["url"] != null) {
        return jsonData['image'][0]["url"];
      }
    } else {
      image = jsonData['image'];
    }
  } else {
    if (jsonData[index]['image'].runtimeType == List) {
      if (jsonData[index]['image'][0].runtimeType == String) {
        return jsonData[index]['image'][0];
      } else if (jsonData[index]['image'][0]['url'] != null) {
        return jsonData[index]['image'][0]['url'];
      } else if (jsonData[index]['image'][0]['image'] != null) {
        return jsonData[index]['image'][0]['url'];
      }
    } else {
      image = jsonData[index]['image'];
    }
  }
  //find image
  if (image.runtimeType == String) {
    return image;
  } else {
    return image['url'];
  }
}

int getCookTime(dynamic jsonData, int index) {
  String data;
  if (index == -1) {
    if (jsonData['cookTime'] == null) {
      return -1;
    }
    data = jsonData['cookTime'];
  } else {
    if (jsonData[index]['cookTime'] == null) {
      return -1;
    }
    data = jsonData[index]['cookTime'];
  }
  print("time found : $data");
  print(DateTime.now().toIso8601String());
  DateTime? time = DateTime.tryParse("2023-04-14T17:08:22.009030");

  print("time: $time");

  try {
    String hourString = data.replaceAll(RegExp(r'[^0-9]'), '');

    int hours = 0;
    int min = 0;
    int total = 0;
    if (hourString.length > 2) {
      hours = int.parse(hourString[0]);
      min = int.parse(hourString.substring(1));
      total = (hours * 60) + min;
    } else {
      total = int.parse(hourString);
    }
    return total;
  } catch (e) {
    return -1;
  }
}

int getPrepTime(dynamic jsonData, int index) {
  print("index = $index");
  String data;
  if (index == -1) {
    if (jsonData['prepTime'] == null) {
      return -1;
    }
    data = jsonData['prepTime'];
  } else {
    if (jsonData[index]['prepTime'] == null) {
      return -1;
    }
    data = jsonData[index]['prepTime'];
  }
  print("time found: $data");
  try {
    String hourString = data.replaceAll(RegExp(r'[^0-9]'), '');

    int hours = 0;
    int min = 0;
    int total = 0;
    if (hourString.length > 2) {
      hours = int.parse(hourString[0]);
      min = int.parse(hourString.substring(1));
      total = (hours * 60) + min;
    } else {
      total = int.parse(hourString);
    }
    return total;
  } catch (e) {
    return -1;
  }
}

int getTotalTime(dynamic jsonData, int index) {
  String data;
  if (index == -1) {
    if (jsonData['totalTime'] == null) {
      return -1;
    }
    data = jsonData['totalTime'];
  } else {
    if (jsonData[index]['totalTime'] == null) {
      return -1;
    }
    data = jsonData[index]['totalTime'];
  }
  try {
    String hourString = data.replaceAll(RegExp(r'[^0-9]'), '');

    int hours = 0;
    int min = 0;
    int total = 0;
    if (hourString.length > 2) {
      hours = int.parse(hourString[0]);
      min = int.parse(hourString.substring(1));
      total = (hours * 60) + min;
    } else {
      total = int.parse(hourString);
    }
    return total;
  } catch (e) {
    return -1;
  }
}

String getRecipeYield(dynamic jsonData, int index) {
  dynamic data;
  if (index == -1) {
    if (jsonData['recipeYield'] == null) {
      return '';
    }
    data = jsonData['recipeYield'];
  } else {
    if (jsonData[index]['recipeYield'] == null) {
      return '';
    }
    data = jsonData[index]['recipeYield'];
  }
  if (data.runtimeType == List) {
    return data[0].toString();
  } else {
    return data.toString();
  }
}

List<Instruction> getRecipeInstructions(dynamic jsonData, int index) {
  List<Instruction> instructions = [];
  List<String> stringInstructions = [];

  dynamic data;
  if (index == -1) {
    data = jsonData['recipeInstructions'];
  } else {
    data = jsonData[index]['recipeInstructions'];
  }

  if (data != null) {
    if (data.runtimeType == String) {
      Instruction instruction = Instruction(
        instruction: data,
        id: generateId(),
        orderNumber: 1,
      );
      return [instruction];
    }

    data = data as List;
  } else {
    //no instructions found
    return [];
  }

  //if list is only Strings of each instruction
  if (data.runtimeType == List && data[0].runtimeType == String) {
    for (var i = 0; i < data.length; i++) {
      List<Instruction> instructions = [];
      Instruction instruction = Instruction(
        instruction: data[i],
        id: generateId(),
        orderNumber: 1,
      );
      instructions.add(instruction);
      return instructions;
    }
  }

  for (var i = 0; i < data.length; i++) {
    if (data[i]['itemListElement'] != null) {
      data = data[i]['itemListElement'];
    }
  }

  data.forEach((element) {
    stringInstructions.add(element["text"]);
  });

  int counter = 0;
  stringInstructions.forEach((element) {
    counter++;
    Instruction instruction = Instruction(
        id: generateId(), instruction: element, orderNumber: counter);
    instructions.add(instruction);
  });

  return instructions;
}

List<Ingredient> getRecipeIngredients(dynamic jsonData, int index) {
  List<Ingredient> ingredients = [];

  dynamic data;
  if (index == -1) {
    data = jsonData['recipeIngredient'];
  } else {
    data = jsonData[index]['recipeIngredient'];
  }

  if (data != null) {
    data = data as List;
  } else {
    return [];
  }

  data.forEach((ingredient) {
    Ingredient ing = Ingredient(
      name: ingredient,
      id: generateId(),
    );
    ingredients.add(ing);
  });

  return ingredients;
}

dynamic getWebsiteDataTest(String uri) async {
  final url = Uri.parse(uri);
  final response = await http.get(url);
  String responseData = response.body;
  dynamic finalData = '';

  while ((response.body.contains('type="application/ld+json"') ||
          response.body.contains('type=application/ld+json')) &&
      (finalData == '' || finalData == null)) {
    int headerIndex = 0;
    if (responseData.contains('type="application/ld+json"') == true) {
      headerIndex = responseData.indexOf('type="application/ld+json"');
    } else {
      headerIndex = responseData.indexOf('type=application/ld+json');
    }
    //int index = response.indexOf('type="application/ld+json"');
    //String data = response.substring(index + 1);
    //int nextIndex = response.indexOf('type="application/ld+json"');
    String parse = responseData.substring(headerIndex);

    int start = parse.indexOf('>');

    final jsonStart = parse.substring(start + 1);

    int end = jsonStart.indexOf('</script>');

    parse = jsonStart.substring(0, end);

    final data = parse;

    final finalJson = json.decode(data);

    if (finalJson.runtimeType == List) {
      for (var i = 0; i < finalJson.length; i++) {
        if (finalJson[i]['@type'].runtimeType == List) {
          for (var j = 0; i < finalJson[i]['@type'].length; i++) {
            if (finalJson[i]['@type'][j] == 'Recipe') {
              return finalJson[i];
            }
          }
        } else {
          if (finalJson[i]['@type'] == 'Recipe') {
            return finalJson[i];
          }
        }
      }
      for (var i = 0; i < finalJson.length; i++) {
        if (finalJson[i]['@context'] == 'https://schema.org/') {
          return finalJson[i];
        }
      }
    } else if (finalJson['@type'] == 'Recipe') {
      return finalJson;
    } else {
      String rest = responseData.substring(headerIndex + 1);
      if (rest.contains('type="application/ld+json"') ||
          rest.contains('type=application/ld+json')) {
        //Skip @Graph check
      } else {
        if (finalJson['name'] == null) {
          finalData = finalJson['@graph'];
        } else {
          finalData = finalJson;
        }
      }
    }
    //print(finalData);
    if (finalData != '' && finalData != null) {
      return finalData;
    }
    //skip past current 'type="application/ld+json"
    responseData = responseData.substring(headerIndex + 1);
    //print("looooooooooooooooooooooooooooooooooooooping");

    //
    //
    //end
    //
    //
  }
  return "";

  //String parse = response.body.substring(headerIndex);
  //print('--------------------------');

  //int start = parse.indexOf('>');

  //final jsonStart = parse.substring(start + 1);

  //int end = jsonStart.indexOf('</script>');

  //parse = jsonStart.substring(0, end);

  //print(parse);

  //removes links
  //while (parse.contains('<a href')) {
  //  int start = parse.indexOf('<a href');
  //  int end = parse.indexOf('</a>') + 3;
  //
  //  parse = parse.substring(0, start) + parse.substring(end, parse.length);
  //}
  //print(parse);

  /*

  final data = parse;

  final finalJson = json.decode(data);

  if (finalJson.runtimeType == List) {
    print("isList");
    for (var i = 0; i < finalJson.length; i++) {
      if (finalJson[i]['@type'].runtimeType == List) {
        for (var j = 0; i < finalJson[i]['@type'].length; i++) {
          if (finalJson[i]['@type'][j] == 'Recipe') {
            return finalJson[i];
          }
        }
      } else {
        if (finalJson[i]['@type'] == 'Recipe') {
          return finalJson[i];
        }
      }
    }
    for (var i = 0; i < finalJson.length; i++) {
      if (finalJson[i]['@context'] == 'https://schema.org/') {
        return finalJson[i];
      }
    }
  } else {
    if (finalJson['name'] == null) {
      print('@graph......');
      print(finalJson['@graph'].runtimeType);
      finalData = finalJson['@graph'];
    } else {
      finalData = finalJson;
    }
  }

  return finalData;

  */

  /*
  print('Recipe Name:' + finalData['name'] + '\n');
  //print('Recipe Prep time:' + finalData['prepTime'] + '\n');
  //print('Recipe Cook Time:' + finalData['cookTime'] + '\n');
  //print('Recipe Yield:' + finalData['recipeYield'].toString() + '\n');
  print('Recipe Image:' + finalData['image'].toString() + '\n');
  print('Recipe Ingredient:' + finalData['recipeIngredient'].toString() + '\n');
  print('Recipe Instructions:' +
      finalData['recipeInstructions'].toString() +
      '\n');
  */
}
