import 'package:flutter/material.dart';

import 'todo_card.dart';
import 'todo_form.dart';
import 'models/todos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 30, 106, 157)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TODO List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Todos todos = Todos();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            TodoForm(
                onAdd: (String todo) =>
                    setState(() => todos.addTodo(Todo(value: todo)))),
            ...todos
                .getSortedTodos()
                .asMap()
                .map(
                  (idx, todo) => MapEntry(
                    idx,
                    TodoCard(
                      task: todo.value,
                      isDone: todo.isDone,
                      onDelete: () => setState(() => todos.removeTodo(todo.id)),
                      onCheckboxToggle: (bool v) => setState(() {
                        todos.toggleTodoDone(todo.id, v);
                        todos.setLastEditedTimeToNow(todo.id);
                      }),
                    ),
                  ),
                )
                .values
          ],
        ),
      ),
    );
  }
}
