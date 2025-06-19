import 'package:flutter/material.dart';
import 'package:todoapp/widgets/task_card.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<List<dynamic>> todoList = [
    ['Buy groceries', false],
    ['Study Flutter', false],
    ['Call Mom', false],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: const Text("TODO"),
        backgroundColor: Colors.deepPurple[400],
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: todoList.length,
          separatorBuilder: (context, index) => SizedBox(height: 10), // yeh gap hai
          itemBuilder: (context, index) {
            return TaskCard(
              isChecked: todoList[index][1],
              onChanged: (value) {
                setState(() {
                  todoList[index][1] = value!;
                });
              },
              todoText: todoList[index][0],
            );
          },
        )

      ),
    );
  }
}
