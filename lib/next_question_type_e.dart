import 'package:flutter/material.dart';

enum SelectedAnswer { a, b, c, d }

class NextQuestionEScreen extends StatelessWidget {
  const NextQuestionEScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _questionTitle(),
        body: Center(
          child: ReorderableExample(),
        ),
      ),
    );
  }

  PreferredSizeWidget _questionTitle() {
    return AppBar(
      title: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          text: 'Вопрос типа - E - Выберите несколько вариантов ответов:',
          style: TextStyle(fontSize: 20, color: Colors.black),
        )
      ),
      backgroundColor: Colors.yellow
    );
  }
}

class ReorderableExample extends StatefulWidget {
  final List<String> _items = [
    "предоставление возможности использования студентами и преподавателями интерактивных современных учебных и научных методических комплексов нового типа, основанных на информационно-коммуникационных технологиях",
    "обучение студентов методикам создания программного обеспечения учебного и научного назначения для различных областей человеческой деятельности",
    "формирования у студентов ясного представления об имеющихся межпредметных связях и общенаучных категориях",
    "уменьшение амортизации имущества учебного заведения"
  ];

  ReorderableExample({super.key});

  @override
  State<ReorderableExample> createState() => _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState extends State<ReorderableExample> {
  
  bool _isButtonEnabled = false; 

  late Map<String, bool> answers;

  @override
  void initState() {
    super.initState(); 
    _isButtonEnabled = false;
    answers = { for (var v in widget._items) v: false };
  }

  void _calculateAndShowNextQuestion() {
    Navigator.of(context).pushNamed('/nextQuestion');
  }

  Widget _questionBody() {
    return RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            text: "Целями создания виртуальных лабораторий университетов являются:",
            style: TextStyle(fontSize: 20, color: Colors.black),
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
              for (int index = 0; index < widget._items.length; index += 1)
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  key: Key('$index'),
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text(widget._items[index]),
                  value: answers[widget._items[index]],
                  onChanged:(bool? value) {
                    setState(() {
                      answers[widget._items[index]] = value!;
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