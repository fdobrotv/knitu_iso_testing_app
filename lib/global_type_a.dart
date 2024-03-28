import 'question.dart' show Question;

Stack<dynamic>? questionsTypeABGE;
int earnedPoints = 0;
int maxPoints = 0;

class Stack<E> {
  List<E> _list = <E>[];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();

  Stack(List<E> this._list);
}