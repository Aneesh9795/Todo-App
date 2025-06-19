import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final bool isChecked;
  final String todoText;

  final Function(bool?)? onChanged;

  const TaskCard({
    super.key,
    required this.isChecked,
    required this.todoText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.deepPurple[500],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(value: isChecked, onChanged: onChanged),
          Text(
            'Todo',
            style: TextStyle(
              decoration:
                  isChecked ? TextDecoration.lineThrough : TextDecoration.none,
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
