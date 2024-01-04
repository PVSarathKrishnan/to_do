import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:to_do/db/database.dart';
import 'package:to_do/utilities/dialoguebox.dart';
import 'package:to_do/utilities/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool darktheme = true;
  final _mybox = Hive.box("my_box");
  ToDoDataBase db = ToDoDataBase();
  final _controller = TextEditingController();

  Color getBackgroundColor() {
    return darktheme ? Colors.black : Colors.white;
  }

  Color getTextColor() {
    return darktheme ? Colors.white : Colors.black;
  }

  @override
  void initState() {
    if (_mybox.get("key") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogueBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveNewTask,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: createNewTask,
      ),
      appBar: AppBar(
        backgroundColor: darktheme ? Colors.white : Colors.black,
        elevation: 3,
        title: Text(
          "ToDoGo",
          style: GoogleFonts.koulen(
            letterSpacing: 9,
            fontSize: 32,
            color: darktheme ? Colors.black : Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                darktheme = !darktheme;
              });
            },
            icon: darktheme
                ? Icon(
                    Icons.sunny,
                    color: Colors.black,
                  )
                : Icon(
                    Icons.nightlight,
                    color: Colors.white,
                  ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
              backgroundColor: getBackgroundColor(),
              textColor: getTextColor(),
            );
          },
        ),
      ),
    );
  }
}
