import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String todoText;
  final bool isChecked;
  final Function(bool?) onChanged;

  const TaskCard({
    Key? key,
    required this.todoText,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todoText),
      leading: Checkbox(
        value: isChecked,
        onChanged: onChanged,
      ),
    );
  }
}
