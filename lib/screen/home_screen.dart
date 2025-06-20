import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Hive Flutter
import 'add_task_screen.dart'; // Import the add task screen
import 'task_card.dart'; // Your TaskCard widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  late Box _todoBox; // Hive box

  @override
  void initState() {
    super.initState();
    _todoBox = Hive.box('todoBox');  // Access Hive box
  }

  // Save New Task to Hive Box
  void saveNewTask() {
    String task = _controller.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        _todoBox.add([task, false]); // Add new task to Hive box
        _controller.clear(); // Clear input field
      });
      Navigator.of(context).pop();
    }
  }

  // Update Task in Hive Box
  void updateTask(int index, String updatedTask) {
    setState(() {
      _todoBox.putAt(index, [updatedTask, false]); // Update the task
    });
    Navigator.of(context).pop(); // Close the dialog
  }

  // Create New Task
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

  // Edit Task (show dialog to edit)
  void editTask(int index, String currentTask) {
    _controller.text = currentTask; // Set the current task in controller
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Task"),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Update your task"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                updateTask(index, _controller.text); // Update the task
              },
              child: const Text("Save"),
            ),
          ],
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
        child: ValueListenableBuilder(
          valueListenable: _todoBox.listenable(),
          builder: (context, Box box, _) {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var task = box.getAt(index)[0]; // Get task name
                var isChecked = box.getAt(index)[1]; // Get completion status
                return Dismissible(
                  key: Key(task),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      box.deleteAt(index); // Delete task from box
                    });
                  },
                  child: ListTile(
                    title: Text(task),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => editTask(index, task), // Edit task
                    ),
                    leading: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          box.putAt(index, [task, value!]);
                        });
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
