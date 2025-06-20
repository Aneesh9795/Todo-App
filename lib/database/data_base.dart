import 'package:hive/hive.dart';

class TodoDataBase {
  List TodoList = [];

  final _myBox = Hive.box('mybox');


  void createData() {
    TodoList = [
      ['Buy groceries', false],
      ['Study Flutter', false],
      ['Call Mom', false],
    ];
    _myBox.put('TODOLIST', TodoList);

  // Load data from Hive
  void loadData() {
    if (_myBox.get("TODOLIST") == null) {
      createData();  // If no data exists, create default data
    } else {
      TodoList = _myBox.get("TODOLIST");
    }
  }


  void updateDataBase() {
    _myBox.put("TODOLIST", TodoList);
  }
}
