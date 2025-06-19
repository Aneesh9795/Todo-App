import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/database/data_base.dart';
import 'add_task_screen.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  final _myBox = Hive.box("mybox");
  TodoDataBase db = TodoDataBase();


  void initState(){
    if(_myBox.get("TODOLIIST") == null){
      db.createData();
    }else {
      db.loadData();
    }
    super.initState();
  }

  // List<List<dynamic>> todoList = [
  //   ['Buy groceries', false],
  //   ['Study Flutter', false],
  //   ['Call Mom', false],
  // ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.TodoList[index][1] = !db.TodoList[index][1];
    });
  }

  void saveNewTask() {
    String task = _controller.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        db.TodoList.add([task, false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTaskScreen(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: db.TodoList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                padding: const EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                setState(() {
                  db.TodoList.removeAt(index);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Task Deleted")),
                );
              },
              child: TaskCard(
                isChecked: db.TodoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                todoText: db.TodoList[index][0],
              ),
            );
          },
        ),
      ),
    );
  }
}
