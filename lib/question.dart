import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:knitu_iso_testing_app/question_arguments.dart';

List<dynamic> parseQuestions(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
  return parsed.map<dynamic>((json) => Question.fromJson(json)).toList();
}

Future<List<dynamic>> fetchQuestions() async {
  final String response = await rootBundle.loadString('assets/questions.json');
  return parseQuestions(response);
}

class Question implements QuestionABDEV, QuestionG {
  @override
  late int number;

  @override
  late List<String> rightAnswers;

  @override
  late Map<String, String> answersMatch;

  @override
  late String title;

  @override
  late QuestionType type;

  @override
  late List<String> variants;

  @override
  late List<String> staticVariants;
  
  static fromJson(Map<String, dynamic> json) {
    QuestionType questionType = QuestionType.fromLetter(json['type']);

    if (questionType != QuestionType.g) {
      return QuestionABDEV.fromJson(json);
    } else {
      return QuestionG.fromJson(json);
    }
  }
}

class QuestionABDEV extends BaseQuestion {
  final List<String> rightAnswers;

  const QuestionABDEV({
    required super.number, 
    required super.type, 
    required super.title,
    required super.variants,
    required this.rightAnswers
  });

  factory QuestionABDEV.fromJson(Map<String, dynamic> json) {
    QuestionType questionType = QuestionType.fromLetter(json['type']);

    return QuestionABDEV(
      number: json['number'] as int,
      type: questionType,
      title: json['title'] as String,
      variants: List<String>.from(json['variants']),
      rightAnswers: List<String>.from(json['rightAnswers']),
    );
  }
}

class QuestionG extends BaseQuestion {

  final Map<String, String> answersMatch;
  final List<String> staticVariants;

  const QuestionG({
    required super.number, 
    required super.type, 
    required super.title,
    required super.variants,
    required this.answersMatch,
    required this.staticVariants
  });

  factory QuestionG.fromJson(Map<String, dynamic> json) {
    QuestionType questionType = QuestionType.fromLetter(json['type']);
    List<Map> rightAnswers = List<Map>.from(json['rightAnswers']);
    Map<String, String> rightAnswersMap = { for (var v in rightAnswers) v.entries.first.key: v.entries.first.value as String };
    return QuestionG(
      number: json['number'] as int,
      type: questionType,
      title: json['title'] as String,
      variants: List<String>.from(json['variants']),
      answersMatch: rightAnswersMap,
      staticVariants: List<String>.from(json['staticVariants']),
    );
  }
}

abstract class BaseQuestion {
  final int number;
  final QuestionType type;
  final String title;
  final List<String> variants;

  const BaseQuestion( {
    required this.number,
    required this.type,
    required this.title,
    required this.variants
  });
}