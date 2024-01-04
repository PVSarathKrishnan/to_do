import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];
  final _mybox = Hive.box("my_box");

  // run this method if this is the first time opening the app
  void createInitialData() {
    toDoList = [
      ["Welcome to todogo", true],
      ["Slide to delete", false]
    ];
  }

  // Load the data
  void loadData() {
    toDoList = _mybox.get("key");
  }

  // update the data
  void updateData() {
    _mybox.put("key", toDoList);
  }
}
