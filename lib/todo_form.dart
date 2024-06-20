import 'package:flutter/material.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({super.key, required this.onAdd});

  final Function(String) onAdd;

  @override
  State<TodoForm> createState() => _TodoForm();
}

class _TodoForm extends State<TodoForm> {
  final TextEditingController todoInputController = TextEditingController();

  bool submit = false;

  @override
  void initState() {
    super.initState();
    todoInputController.addListener(() {
      setState(() {
        submit = todoInputController.text.isNotEmpty;
      });
    });
  }

  void _handleAdd() {
    widget.onAdd(todoInputController.text);
    todoInputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: todoInputController,
              decoration: const InputDecoration(
                hintText: "Enter a new todo",
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: submit ? _handleAdd : null,
          )
        ],
      ),
    );
  }
}
