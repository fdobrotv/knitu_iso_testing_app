import 'package:flutter/material.dart';
import 'main_menu.dart';
import 'question.dart';
import 'package:flutter/services.dart' show rootBundle; 
import 'global_type_a.dart' as global;

Future<List<dynamic>> questions = fetchQuestions();

void main() => runApp(MyApp());

class MyApp extends StatefulWidget { 
  @override 
  State<MyApp> createState() => _MyAppState(); 
} 

class _MyAppState extends State<MyApp> { 
  List<dynamic>? questions; 
  Future<void> loadJsonAsset() async { 
    // final List<Question> jsonString = await questions; 
    final String jsonString = await rootBundle.loadString('assets/questions.json'); 
    final List<dynamic> parsed = parseQuestions(jsonString);

    //TODO: Make it configurable via JSON
    int questionsLimitPerTest = 6;

    parsed.shuffle();

    List<dynamic> limited = parsed.sublist(0, questionsLimitPerTest);

    // var data = jsonDecode(jsonString); 
    setState(() { 
      questions = parsed; 
      global.Stack<dynamic> stack = global.Stack(limited);
      global.questionsTypeABGE = stack;
      global.maxPoints = limited.length;
    }); 
    // print(questions); 
  } 
  
  @override 
  void initState() { 
    // TODO: implement initState 
    super.initState(); 
    loadJsonAsset(); 
  } 
  
  @override 
  Widget build(BuildContext context) { 
    return FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 50)),
        builder: (context, snapshot) {
        // Checks whether the future is resolved, ie the duration is over
            if (snapshot.connectionState == ConnectionState.done) {
                return const SignUpApp();
            }
            else {
                return Container(); // Return empty container to avoid build errors
            }
        }
    );
  } 
} 

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});
  
  @override
  Widget build(BuildContext context) {

    // List<Question> questions = await questions;

    return MaterialApp(
      routes: {
        '/': (context) => const SignUpScreen(),
        '/welcome': (context) => const MainScreen(),
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _formProgress = 0;

  void _showWelcomeScreen() {
    Navigator.of(context).pushNamed('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _formProgress),
          Text('Регистрация', style: Theme.of(context).textTheme.headlineMedium),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _firstNameTextController,
              decoration: const InputDecoration(hintText: 'Имя'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: const InputDecoration(hintText: 'Фамилия'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: const InputDecoration(hintText: 'Отчество'),
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
            onPressed: _showWelcomeScreen,
            child: const Text('Зарегистрироваться'),
          ),
        ],
      ),
    );
  }
}