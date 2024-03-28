import 'package:flutter/material.dart';

enum SelectedAnswer { a, b, c, d }

class NextQuestionDScreen extends StatelessWidget {
  const NextQuestionDScreen({super.key});

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
          text: 'Вопрос типа - Д - Расставьте по порядку:',
          style: TextStyle(fontSize: 20, color: Colors.black),
        )
      ),
      backgroundColor: Colors.yellow
    );
  }
}

class ReorderableExample extends StatefulWidget {
  final List<String> _items = [
    "Средства создания электронных курсов", 
    "Средства управления учебными курсами", 
    "Средства управления процессом обучения", 
    "Системы управления обучением и учебным материалом"
  ];

  ReorderableExample({super.key});

  

  @override
  State<ReorderableExample> createState() => _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState extends State<ReorderableExample> {
  bool _isButtonEnabled = false; 

  @override
  void initState() {
    super.initState(); 
    _isButtonEnabled = false;
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
        // _questionBody(), 
        Flexible(
          flex: 1,
          child: ReorderableListView(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          children: <Widget>[
            for (int index = 0; index < widget._items.length; index += 1)
              ListTile(
                key: Key('$index'),
                tileColor: index.isOdd ? oddItemColor : evenItemColor,
                title: Text('Item ${widget._items[index]}'),
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final String item = widget._items.removeAt(oldIndex);
              widget._items.insert(newIndex, item);
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
      ]
    );
  }
}

// class ReorderableExample extends StatefulWidget {
//   const ReorderableExample({super.key});

//   @override
//   State<ReorderableExample> createState() => _ReorderableListViewExampleState();
// }

// class _ReorderableListViewExampleState extends State<ReorderableExample> {
//   final List<int> _items = List<int>.generate(4, (int index) => index);

//   // SelectedAnswer? _character = SelectedAnswer.a;

//   void _showNextQuestion() {
//     Navigator.of(context).pushNamed('/nextQuestion');
//   }

//   Widget _questionBody() {
//     return RichText(
//           textAlign: TextAlign.center,
//           text: const TextSpan(
//             text: 'Расставьте в иерархии по степени сложности системы дистанционного обучения начиная от основания пирамиды.',
//             style: TextStyle(fontSize: 20, color: Colors.black),
//           )
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;
//     final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
//     final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

//     return 
//     Column(
//       children: <Widget>[
//         _questionBody(),
//         Expanded(
//                     child: ReorderableListView(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       children: <Widget>[
//                         // for (int index = 0; index < _items.length; index += 1)
//                         //   ListTile(
//                         //     key: Key('$index'),
//                         //     tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
//                         //     title: Text('Item ${_items[index]}'),
//                         //   ),
//                         ListTile(
//                           key: const Key('first'),
//                           tileColor: _items[0].isOdd ? oddItemColor : evenItemColor,
//                           title: const Text('Средства создания электронных курсов'),
//                         ),
//                         ListTile(
//                           key: const Key('second'),
//                           tileColor: _items[1].isOdd ? oddItemColor : evenItemColor,
//                           title: const Text('Средства управления учебными курсами'),
//                         ),
//                         ListTile(
//                           key: const Key('third'),
//                           tileColor: _items[2].isOdd ? oddItemColor : evenItemColor,
//                           title: const Text('Средства управления процессом обучения'),
//                         ),
//                         ListTile(
//                           key: const Key('forth'),
//                           tileColor: _items[3].isOdd ? oddItemColor : evenItemColor,
//                           title: const Text('Системы управления обучением и учебным материалом'),
//                         ),
//                       ],
//                       onReorder: (int oldIndex, int newIndex) {
//                         setState(() {
//                           if (oldIndex < newIndex) {
//                             newIndex -= 1;
//                           }
//                           final int item = _items.removeAt(oldIndex);
//                           _items.insert(newIndex, item);
//                         });
//                       },
//                     ),
//                   ),
//         TextButton(
//             style: ButtonStyle(
//               foregroundColor: MaterialStateProperty.resolveWith((states) {
//                 return states.contains(MaterialState.disabled)
//                     ? null
//                     : Colors.white;
//               }),
//               backgroundColor: MaterialStateProperty.resolveWith((states) {
//                 return states.contains(MaterialState.disabled)
//                     ? null
//                     : Colors.blue;
//               }),
//             ),
//             onPressed: _showNextQuestion,
//             child: const Text('Next question'),
//           ),
//       ],
//     );
//   }
// }