import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:whats_for_dinner/models/recipe.dart';

String generateId() {
  return DateTime.now().toString();
}

String filterErrorMessage(String e) {
  int newIndex;
  if (e.contains("]")) {
    newIndex = e.indexOf("]") + 1;
  } else {
    newIndex = 0;
  }
  return e.substring(newIndex);
}

String trimSourceUrl(String url) {
  if (url.trim() == "") {
    return "";
  }
  int start = 0;
  if (url.contains('https://')) {
    start = url.indexOf('https://') + 8;
  }
  if (url.contains('www')) {
    start = url.indexOf('www') + 4;
  }

  url = url.substring(start);

  int end = url.indexOf('/');

  if (end == -1) {
    return url;
  } else {
    return url.substring(0, end);
  }
}

void showSnackBar(String header, String subHeader) {
  Get.snackbar(
    header,
    subHeader,
  );
}

String parseUrl(String url) {
  if (url[url.length - 1] == '/') {
    url = url.substring(0, url.length - 1);
  }

  var index = 0;
  for (var i = 0; i < url.length; i++) {
    if (url[i] == '/') {
      index = i;
    }
  }
  url = url.substring(index + 1);
  url = url.replaceAll('-', ' ');
  url = url.replaceAll('_', ' ');
  url = url.replaceAll('0', '');
  url = url.replaceAll('1', '');
  url = url.replaceAll('2', '');
  url = url.replaceAll('3', '');
  url = url.replaceAll('4', '');
  url = url.replaceAll('5', '');
  url = url.replaceAll('6', '');
  url = url.replaceAll('7', '');
  url = url.replaceAll('8', '');
  url = url.replaceAll('9', '');

  for (var i = 0; i < url.length; i++) {
    if (i == 0) {
      url = url[i].toUpperCase() + url.substring(1, url.length);
    }
    if (url[i] == ' ') {
      //print(url[i + 1].toUpperCase());
      //url = replaceCharAt(url, i + 1, url[i].toUpperCase());
    }
  }
  return url;
}

String replaceCharAt(String string, int index, String newChar) {
  return string.substring(0, index) + newChar + string.substring(index);
}

searchUrl(String link) {
  Uri url;
  if (!(link.trim().startsWith("https://") ||
      link.trim().startsWith("http://"))) {
    url = Uri.parse("https://$link");
  } else {
    url = Uri.parse(link);
  }

  launchUrl(url);
}

stripPhoneNumber(String phoneNumber) {
  phoneNumber = phoneNumber.replaceAll("(", "");
  phoneNumber = phoneNumber.replaceAll(")", "");
  phoneNumber = phoneNumber.replaceAll("-", "");
  phoneNumber = phoneNumber.replaceAll(" ", "");
  return phoneNumber;
}

bool validatePhoneNumber(String phoneNumber) {
  String validator = r'(^(?:[+0]9)?[0-9]{5,13}$)';
  RegExp regex = RegExp(validator);
  if (regex.hasMatch(phoneNumber)) {
    return true;
  } else {
    return false;
  }
}

String formatPhoneNumber(String validNumber) {
  String formattePhoneNumber;
  switch (validNumber.length) {
    case 10:
      //phone number is 10 digits
      String p1 = validNumber.substring(0, 3);
      String p2 = validNumber.substring(3, 6);
      String p3 = validNumber.substring(6);
      formattePhoneNumber = "($p1) $p2-$p3";
      return formattePhoneNumber;
    case 11:
      //phone number is 11 digits
      String extension = validNumber.substring(0, 1);
      String p1 = validNumber.substring(1, 4);
      String p2 = validNumber.substring(4, 7);
      String p3 = validNumber.substring(7);
      return formattePhoneNumber = "+$extension ($p1) $p2-$p3";

    case 12:
      //phone number is 12 digits
      String extension = validNumber.substring(0, 2);
      String p1 = validNumber.substring(2, 5);
      String p2 = validNumber.substring(5, 8);
      String p3 = validNumber.substring(8);
      return formattePhoneNumber = "+$extension ($p1) $p2-$p3";

    case 13:
      //phone number is 13 digits
      String extension = validNumber.substring(0, 3);
      String p1 = validNumber.substring(3, 6);
      String p2 = validNumber.substring(6, 9);
      String p3 = validNumber.substring(9);
      return formattePhoneNumber = "+$extension ($p1) $p2-$p3";
    default:
      return validNumber;
  }
}
