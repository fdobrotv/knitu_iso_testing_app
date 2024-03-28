import 'package:flutter/material.dart';
import 'package:knitu_iso_testing_app/main_menu.dart';
import 'global_type_a.dart' as global;

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Результаты тестирования')),
        body: const Center(
          child: Results(),
        ),
      ),
      routes: {
        '/welcome': (context) => const MainScreen(),
      },
    );
  }
}

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  void _showWelcomeScreen() {
    Navigator.of(context).pushNamed('/welcome');
  }

  String? data;

  @override
  void initState() {
    super.initState(); 
    data = "Получено очков: ${global.earnedPoints} из ${global.maxPoints} возможных";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(data!),
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
          onPressed: _showWelcomeScreen,
          child: const Text('На главный экран!'),
        ),
      ],
    );
  }
}