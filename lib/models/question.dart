import 'package:flutter/material.dart';

class MyQuestion {
  final String question;
  final List<String> options;
  final String answer;

  const MyQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });

  static MyQuestion fromJson(json) => MyQuestion(
      question: json["question"],
      options: json['options'].cast<String>(),
      answer: json["answer"],
  );
}
