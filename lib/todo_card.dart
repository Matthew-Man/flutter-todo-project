import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  const TodoCard(
      {super.key,
      required this.task,
      required this.isDone,
      required this.onDelete,
      required this.onCheckboxToggle});

  final String task;
  final bool isDone;
  final Function(bool) onCheckboxToggle;
  final Function() onDelete;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Checkbox(
              value: widget.isDone,
              onChanged: (bool? v) => {widget.onCheckboxToggle(v!)}),
          Expanded(child: Text(widget.task)),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onDelete,
          )
        ],
      ),
    );
  }
}
