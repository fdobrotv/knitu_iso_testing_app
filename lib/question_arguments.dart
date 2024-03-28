enum QuestionType {
  a(letter: "A"), 
  b(letter: "B"), 
  d(letter: "D"), 
  g(letter: "G"), 
  v(letter: "V"),
  e(letter: "E");

  const QuestionType({required this.letter});

  final String letter;

  static fromLetter(String letter) {
    return switch (letter.toUpperCase()) {
        'A' => QuestionType.a,
        'B' => QuestionType.b,
        'D' => QuestionType.d,
        'G' => QuestionType.g,
        'V' => QuestionType.v,
        'E' => QuestionType.e,
        _ => throw const FormatException('Invalid question type!')
      };
  }
}

class QuestionArguments {
  final QuestionType type;
  final String title;
  final List<String> variants;
  final List<String> rightAnswers;

  QuestionArguments(this.type, this.title, this.variants, this.rightAnswers);
}