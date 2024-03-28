import 'package:flutter/material.dart';

enum SelectedAnswer { a, b, c, d }

class NextQuestionBScreen extends StatelessWidget {
  const NextQuestionBScreen({super.key});

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
          text: 'Вопрос типа - Б',
          style: TextStyle(fontSize: 20, color: Colors.black),
          // children: <TextSpan>[
          //               TextSpan(
          //                 text: '\nTrip List',
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                 ),
          //               ),
          //             ]
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
  SelectedAnswer? _character = SelectedAnswer.a;

  void _showNextQuestion() {
    Navigator.of(context).pushNamed('/nextQuestion');
  }

  Widget _questionBody() {
    return RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            text: 'Кого принято считать основоположником технологии дистанционного обучения:',
            style: TextStyle(fontSize: 20, color: Colors.black),
            // children: <TextSpan>[
            //               TextSpan(
            //                 // text: '\nTrip List',
            //                 // style: TextStyle(
            //                 //   fontSize: 16,
            //                 // ),
            //               ),
            //             ]
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _questionBody(),
        ListTile(
          title: const Text('Исаак Ньютон'),
          leading: Radio<SelectedAnswer>(
            value: SelectedAnswer.a,
            groupValue: _character,
            onChanged: (SelectedAnswer? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Исаак Питман'),
          leading: Radio<SelectedAnswer>(
            value: SelectedAnswer.b,
            groupValue: _character,
            onChanged: (SelectedAnswer? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Вилхелм Рьонтген'),
          leading: Radio<SelectedAnswer>(
            value: SelectedAnswer.c,
            groupValue: _character,
            onChanged: (SelectedAnswer? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Агрегаторы онлайн-игр'),
          leading: Radio<SelectedAnswer>(
            value: SelectedAnswer.d,
            groupValue: _character,
            onChanged: (SelectedAnswer? value) {
              setState(() {
                _character = value;
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
            onPressed: _showNextQuestion,
            child: const Text('Next question'),
          ),
      ],
    );
  }
}