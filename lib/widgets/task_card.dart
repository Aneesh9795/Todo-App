import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String todoText;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const TaskCard({
    super.key,
    required this.todoText,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.deepPurple[400],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(value: isChecked, onChanged: onChanged),
          Expanded(
            child: Text(
              todoText,
              style: TextStyle(
                fontSize: 16,
                decoration: isChecked ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
