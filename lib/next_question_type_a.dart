import 'package:flutter/material.dart';
import 'package:knitu_iso_testing_app/question.dart';
import 'package:knitu_iso_testing_app/question_arguments.dart';
import 'package:knitu_iso_testing_app/results.dart';
import 'global_type_a.dart' as global;
import 'package:collection/collection.dart';

class NextQuestionScreen extends StatelessWidget {
  const NextQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final questionArguments = ModalRoute.of(context)!.settings.arguments as QuestionArguments;

    final dynamic question = global.questionsTypeABGE!.pop();

    Widget questionWidgetByType = switch (question.type) {
      QuestionType.a || QuestionType.b || QuestionType.v => QuestionTypeAB(question: question),
      QuestionType.d => QuestionTypeD(question: question),
      QuestionType.g => QuestionTypeG(question: question),
      QuestionType.e => QuestionTypeE(question: question),
      _ => throw const FormatException('Invalid question type!')
    };

    return MaterialApp(
      home: Scaffold(
        appBar: _questionTitle(question.type),
        body: Center(
          child: questionWidgetByType,
        ),
      ),
      routes: {
        '/nextQuestion': (context) => const NextQuestionScreen(),
        '/results': (context) => const ResultsScreen(),
      },
    );
  }

  PreferredSizeWidget _questionTitle(QuestionType questionType) {
    String baseText = "Вопрос типа -";
    var text = switch (questionType) {
      QuestionType.a => "$baseText A - Верно ли утверждение?",
      QuestionType.b => "$baseText Б - Выберите правильный ответ.",
      QuestionType.d => "$baseText Д - Расставьте по порядку:",
      QuestionType.g => "$baseText Г - Соотнесите:",
      QuestionType.v => "$baseText В - Вставьте пропущенное слово в следующее определение:",
      QuestionType.e => "$baseText E - Выберите несколько вариантов ответов:"
    };

    return AppBar(
      title: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: text,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        )
      ),
      backgroundColor: Colors.yellow
    );
  }
}

class QuestionTypeE extends StatefulWidget {
  final QuestionABDEV question;

  const QuestionTypeE({
    super.key,
    required this.question,
  });

  @override
  State<QuestionTypeE> createState() => QuestionTypeEState();
}

class QuestionTypeEState extends State<QuestionTypeE> {
  Function eq = const ListEquality().equals;
  bool _isButtonEnabled = false; 

  late Map<String, bool> answers;

  @override
  void initState() {
    super.initState(); 
    _isButtonEnabled = false;
    answers = { for (var v in widget.question.variants) v: false };
  }

  void _calculateAndShowNextQuestion() {
    final filteredMap = {
      for (final key in answers.keys)
        if (answers[key] == true) key: answers[key]
    };
    List<String> selected = filteredMap.keys.toList();
    // print(eq(selected, widget.question.rightAnswers));
    if (eq(selected, widget.question.rightAnswers)) {
      setState(() {
        global.earnedPoints += 1;
      });
    }

    if (global.questionsTypeABGE!.isNotEmpty) {
      Navigator.of(context).pushNamed('/nextQuestion');
    } else {
      Navigator.of(context).pushNamed('/results');
    }
  }

  Widget _questionBody() {
    return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: widget.question.title,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Column(
      children: <Widget>[
        _questionBody(), 
        Flexible(
          flex: 1,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            children: <Widget>[
              for (int index = 0; index < widget.question.variants.length; index += 1)
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  key: Key('$index'),
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text(widget.question.variants[index]),
                  value: answers[widget.question.variants[index]],
                  onChanged:(bool? value) {
                    setState(() {
                      answers[widget.question.variants[index]] = value!;
                    });
                    _isButtonEnabled = true;
                  },
                ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: _isButtonEnabled
              ? _calculateAndShowNextQuestion
              : null,
            child: const Text('Следующий вопрос'),
          ),
        ),
      ],
    );
  }
}

class QuestionTypeG extends StatefulWidget {
  final QuestionG question;

  const QuestionTypeG({
    super.key,
    required this.question,
  });

  @override
  State<QuestionTypeG> createState() => QuestionTypeGState();
}

class QuestionTypeGState extends State<QuestionTypeG> {
  Function eq = const ListEquality().equals;
  bool _isButtonEnabled = false; 

  @override
  void initState() {
    super.initState(); 
    _isButtonEnabled = false;
  }

  void _calculateAndShowNextQuestion() {
    List<String> rightAnswer = widget.question.answersMatch.values.toList();
    print(eq(widget.question.variants, rightAnswer));
    if (eq(widget.question.variants, rightAnswer)) {
      // print("Right answer: $_character");
      setState(() {
        global.earnedPoints += 1;
      });
    }

    if (global.questionsTypeABGE!.isNotEmpty) {
      Navigator.of(context).pushNamed('/nextQuestion');
    } else {
      Navigator.of(context).pushNamed('/results');
    }
  }

  Widget _questionBody() {
    return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: widget.question.title,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Column(
      children: <Widget>[
        _questionBody(), 
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  children: <Widget>[
                    for (int index = 0; index < widget.question.variants.length; index += 1)
                      ListTile(
                        key: Key('$index'),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(widget.question.staticVariants[index]),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ReorderableListView(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  children: <Widget>[
                    for (int index = 0; index < widget.question.variants.length; index += 1)
                      ListTile(
                        key: Key('$index'),
                        // key: ValueKey(widget.question.variants[index]),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(widget.question.variants[index]),
                      ),
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final String item = widget.question.variants.removeAt(oldIndex);
                      widget.question.variants.insert(newIndex, item);
                      _isButtonEnabled = true;
                    });
                  },
                ),
              ),
            ],
          )
        ),
        Flexible(
          flex: 1,
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: _isButtonEnabled
              ? _calculateAndShowNextQuestion
              : null,
            child: const Text('Следующий вопрос'),
          ),
        ),
      ],
    );
  }
}

class QuestionTypeD extends StatefulWidget {
  final QuestionABDEV question;

  const QuestionTypeD({
    super.key,
    required this.question,
  });

  @override
  State<QuestionTypeD> createState() => QuestionTypeDState();
}

class QuestionTypeDState extends State<QuestionTypeD> {
  Function eq = const ListEquality().equals;
  bool _isButtonEnabled = false; 

  @override
  void initState() {
    super.initState(); 
    _isButtonEnabled = false;
  }

  void _calculateAndShowNextQuestion() {
    
    print(eq(widget.question.variants, widget.question.rightAnswers));
    if (eq(widget.question.variants, widget.question.rightAnswers)) {
      // print("Right answer: $_character");
      setState(() {
        global.earnedPoints += 1;
      });
    }

    if (global.questionsTypeABGE!.isNotEmpty) {
      Navigator.of(context).pushNamed('/nextQuestion');
    } else {
      Navigator.of(context).pushNamed('/results');
    }
  }

  Widget _questionBody() {
    return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: widget.question.title,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Column(
      children: <Widget>[
        _questionBody(), 
        Flexible(
          flex: 1,
          child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            children: <Widget>[
              for (int index = 0; index < widget.question.variants.length; index += 1)
                ListTile(
                  key: Key('$index'),
                  // key: ValueKey(widget.question.variants[index]),
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text(widget.question.variants[index]),
                ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final String item = widget.question.variants.removeAt(oldIndex);
                widget.question.variants.insert(newIndex, item);
                _isButtonEnabled = true;
              });
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: _isButtonEnabled
              ? _calculateAndShowNextQuestion
              : null,
            child: const Text('Следующий вопрос'),
          ),
        ),
      ],
    );
  }
}


class QuestionTypeAB extends StatefulWidget {
  final QuestionABDEV question;
  const QuestionTypeAB({
    super.key,
    required this.question
  });

  @override
  State<QuestionTypeAB> createState() => _QuestionTypeABState();
}

class _QuestionTypeABState extends State<QuestionTypeAB> {
  

  bool _isButtonEnabled = false; 
  String? _character; //question.variants[0]

  @override
  void initState() {
    super.initState(); 
    _isButtonEnabled = false;
  }

  void _calculateAndShowNextQuestion() {
    if (_character != null && widget.question.rightAnswers.contains(_character)) {
      // print("Right answer: $_character");
      setState(() {
        global.earnedPoints += 1;
      });
    }

    if (global.questionsTypeABGE!.isNotEmpty) {
      Navigator.of(context).pushNamed('/nextQuestion');
    } else {
      Navigator.of(context).pushNamed('/results');
    }
  }

  Widget _questionBody() {
    return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: widget.question.title,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    var variants = widget.question.variants;
    // variants.shuffle();

    return Column(
      children: <Widget>[
        _questionBody(), 
        for (String choice in variants)
          ListTile(
            title: Text(choice),
            leading: Radio<String>(
              value: choice,
              groupValue: _character,
              onChanged: (String? value) {
                setState(() {
                  _character = value;
                  _isButtonEnabled = true;
                });
              },
            ),
          ),
        TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: _isButtonEnabled
              ? _calculateAndShowNextQuestion
              : null,
            child: const Text('Следующий вопрос'),
          ),
      ],
    );
  }
}