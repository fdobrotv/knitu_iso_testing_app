import 'package:flutter/material.dart';
import 'package:knitu_iso_testing_app/question.dart';
import 'package:knitu_iso_testing_app/question_arguments.dart';

class NextQuestionGScreen extends StatelessWidget {
  const NextQuestionGScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _questionTitle(),
        body: const Center(
          child: RadioExample(),
        ),
      ),
    );
  }

  PreferredSizeWidget _questionTitle() {
    return AppBar(
      title: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          text: 'Вопрос типа - Г - Соотнесите:',
          style: TextStyle(fontSize: 20, color: Colors.black),
        )
      ),
      backgroundColor: Colors.yellow
    );
  }
}

class RadioExample extends StatefulWidget {

  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  final List<int> _items = List<int>.generate(50, (int index) => index);
  bool _isButtonEnabled = false; 

  QuestionG question = const QuestionG(
    number: 50, 
    type: QuestionType.g, 
    title: "Some title", 
    staticVariants: ["Super", "Duper"],
    variants: ["First", "Second"], 
    answersMatch: {"Super": "First", "Duper": "Second"}, 
  );

  @override
  void initState() {
    super.initState(); 
    _isButtonEnabled = false;
  }

  void _showNextQuestion() {
    Navigator.of(context).pushNamed('/nextQuestion');
  }

  Widget _questionBody() {
    return RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            text: 'Тип программного продукта с его названием.',
            style: TextStyle(fontSize: 20, color: Colors.black),
          )
        );
  }

   void _calculateAndShowNextQuestion() {
    Navigator.of(context).pushNamed('/nextQuestion');
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
                    for (int index = 0; index < question.variants.length; index += 1)
                      ListTile(
                        key: Key('$index'),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(question.staticVariants[index]),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ReorderableListView(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  children: <Widget>[
                    for (int index = 0; index < question.variants.length; index += 1)
                      ListTile(
                        key: Key('$index'),
                        // key: ValueKey(widget.question.variants[index]),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(question.variants[index]),
                      ),
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final String item = question.variants.removeAt(oldIndex);
                      question.variants.insert(newIndex, item);
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