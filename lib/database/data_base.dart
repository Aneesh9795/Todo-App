import 'package:hive/hive.dart';

class TodoDataBase {
  List TodoList = [];

final _myBox = Hive.box('mybox');

void createData(){
  TodoList = [
    ['Buy groceries', false],
    ['Study Flutter', false],
    ['Call Mom', false],
  ];
}


 void loadData(){
  TodoList = _myBox.get("TODOLIST");
 }

 void updateDataBase(){
  _myBox.put("TODOLIST",TodoList);
 }

}