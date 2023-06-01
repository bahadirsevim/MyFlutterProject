import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:local_json_project4/models/question.dart';

class QuestionApi{
  static Future<List<MyQuestion>> getUsersLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString("assets/questions.json");
    final body = json.decode(data);

    return body.map<MyQuestion>(MyQuestion.fromJson).toList();
  }
}