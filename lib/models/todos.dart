import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Todo {
  final String id = const Uuid().v4();
  String value = "";
  bool isDone = false;
  DateTime lastEdited = DateTime.now();

  Todo({required this.value, isDone});
}

class Todos with ChangeNotifier {
  final List<Todo> _todos = [
    Todo(value: "First test todo"),
    Todo(value: "Second test todo")
  ];

  List<Todo> get todos {
    return [..._todos];
  }

  List<Todo> getSortedTodos() {
    List<Todo> doneTasks = _todos.where((todo) => todo.isDone).toList();
    List<Todo> notDoneTasks = _todos.where((todo) => !todo.isDone).toList();

    // Sort by last edited
    doneTasks.sort((a, b) => b.lastEdited.compareTo(a.lastEdited));
    notDoneTasks.sort((a, b) => b.lastEdited.compareTo(a.lastEdited));

    return [...notDoneTasks, ...doneTasks];
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggleTodoDone(String id, bool v) {
    Todo todo = _todos.firstWhere((todo) => todo.id == id);
    todo.isDone = v;
    notifyListeners();
  }

  void setLastEditedTimeToNow(String id) {
    Todo todo = _todos.firstWhere((todo) => todo.id == id);
    todo.lastEdited = DateTime.now();
    notifyListeners();
  }
}
