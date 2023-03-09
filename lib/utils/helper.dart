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

String trimSourceUrl(String url) {
  int start = 0;
  if (url.contains('www')) {
    start = url.indexOf('www') + 4;
  } else {
    start = url.indexOf('https://') + 8;
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
  Uri url = Uri.parse(link);
  launchUrl(url);
}
