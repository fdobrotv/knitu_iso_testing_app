import 'package:flutter/material.dart';
import 'package:knitu_iso_testing_app/next_question_type_e.dart';
import 'next_question_type_a.dart';
import 'next_question_type_b.dart';
import 'next_question_type_v.dart';
import 'next_question_type_g.dart';
import 'next_question_type_d.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Главное меню')),
        body: const Center(
          child: MainButtonSet(),
        ),
      ),
      routes: {
        '/nextQuestion': (context) => const NextQuestionScreen(),
        '/nextQuestionB': (context) => const NextQuestionBScreen(),
        '/nextQuestionV': (context) => const NextQuestionVScreen(),
        '/nextQuestionG': (context) => const NextQuestionGScreen(),
        '/nextQuestionD': (context) => const NextQuestionDScreen(),
        '/nextQuestionE': (context) => const NextQuestionEScreen(),
      },
    );
  }
}

class MainButtonSet extends StatefulWidget {
  const MainButtonSet({super.key});

  @override
  State<MainButtonSet> createState() => _MainButtonSetState();
}

class _MainButtonSetState extends State<MainButtonSet> {
  void _showNextQuestion() {
    Navigator.of(context).pushNamed('/nextQuestion');
  }

  // void _showNextQuestionB() {
  //   Navigator.of(context).pushNamed('/nextQuestionB');
  // }

  // void _showNextQuestionV() {
  //   Navigator.of(context).pushNamed('/nextQuestionV');
  // }

  // void _showNextQuestionG() {
  //   Navigator.of(context).pushNamed('/nextQuestionG');
  // }

  // void _showNextQuestionD() {
  //   Navigator.of(context).pushNamed('/nextQuestionD');
  // }

  // void _showNextQuestionE() {
  //   Navigator.of(context).pushNamed('/nextQuestionE');
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
          child: const Text('Приступить к тестированию!'),
        ),
        // TextButton(
        //   style: ButtonStyle(
        //     foregroundColor: MaterialStateProperty.resolveWith((states) {
        //       return states.contains(MaterialState.disabled)
        //           ? null
        //           : Colors.white;
        //     }),
        //     backgroundColor: MaterialStateProperty.resolveWith((states) {
        //       return states.contains(MaterialState.disabled)
        //           ? null
        //           : Colors.blue;
        //     }),
        //   ),
        //   onPressed: _showNextQuestionB,
        //   child: const Text('Next question - Б'),
        // ),
        // TextButton(
        //   style: ButtonStyle(
        //     foregroundColor: MaterialStateProperty.resolveWith((states) {
        //       return states.contains(MaterialState.disabled)
        //           ? null
        //           : Colors.white;
        //     }),
        //     backgroundColor: MaterialStateProperty.resolveWith((states) {
        //       return states.contains(MaterialState.disabled)
        //           ? null
        //           : Colors.blue;
        //     }),
        //   ),
        //   onPressed: _showNextQuestionV,
        //   child: const Text('Next question - B'),
        // ),
        // TextButton(
        //   style: ButtonStyle(
        //     foregroundColor: MaterialStateProperty.resolveWith((states) {
        //       return states.contains(MaterialState.disabled)
        //           ? null
        //           : Colors.white;
        //     }),
        //     backgroundColor: MaterialStateProperty.resolveWith((states) {
        //       return states.contains(MaterialState.disabled)
        //           ? null
        //           : Colors.blue;
        //     }),
        //   ),
        //   onPressed: _showNextQuestionG,
        //   child: const Text('Next question - Г'),
        // ),
        // TextButton(
        //   style: ButtonStyle(
        //     foregroundColor: MaterialStateProperty.resolveWith((states) {
        //       return states.contains(MaterialState.disabled)
        //           ? null
        //           : Colors.white;
        //     }),
        //     backgroundColor: MaterialStateProperty.resolveWith((states) {
        //       return states.contains(MaterialState.disabled)
        //           ? null
        //           : Colors.blue;
        //     }),
        //   ),
        //   onPressed: _showNextQuestionD,
        //   child: const Text('Next question - Д'),
        // ),
        // TextButton(
        //   style: ButtonStyle(
        //     foregroundColor: MaterialStateProperty.resolveWith((states) {
        //       return states.contains(MaterialState.disabled)
        //           ? null
        //           : Colors.white;
        //     }),
        //     backgroundColor: MaterialStateProperty.resolveWith((states) {
        //       return states.contains(MaterialState.disabled)
        //           ? null
        //           : Colors.blue;
        //     }),
        //   ),
        //   onPressed: _showNextQuestionE,
        //   child: const Text('Next question - E'),
        // ),
      ],
    );
  }
}