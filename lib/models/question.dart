import 'package:flutter/material.dart';

class MyQuestion {
  final String question;
  final List<Option> options;
  final String answer;

  MyQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });

  static MyQuestion fromJson(json) => MyQuestion(
        question: json["question"],
        options: Option.fromJson(json["options"]),
        answer: json["answer"],
      );
}

class Option {
  final String option;
  bool? isCorrect;
  Option({required this.option});

  static fromJson(json) {
    List<Option> options = [];
    for (var item in json) {
      options.add(Option(option: item["option"]));
    }
    return options;
  }

  @override
  String toString() {
    return option;
  }
}
