import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:to_do/core/database.dart';
import 'package:to_do/presentation/utilities/confir_reset_widget.dart';
import 'package:to_do/presentation/utilities/dialoguebox.dart';
import 'package:to_do/presentation/utilities/todo_tile.dart';
import 'package:url_launcher/url_launcher.dart';

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
          isDarkTheme: darktheme,
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

  void _openDrawer() {
    Scaffold.of(_scaffoldContext!).openEndDrawer();
  }

  BuildContext? _scaffoldContext;

  void clearData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmResetWidget(mybox: _mybox);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  darktheme ? Colors.white : Colors.black,
        foregroundColor:  darktheme ?  Colors.black : Colors.white,
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: darktheme ? Colors.white : Colors.black,
        elevation: 3,
        leading: IconButton(
          tooltip: darktheme ? "switch to lighttheme" : "switch to darktheme",
          onPressed: () {
            setState(() {
              darktheme = !darktheme;
            });
          },
          icon: darktheme
              ? Icon(
                  Icons.sunny,
                  color: Colors.black87,
                )
              : Icon(
                  Icons.nightlight,
                  color: Colors.white,
                ),
        ),
          title: Text(
          "ToDoGo",
          style: GoogleFonts.grapeNuts(
            fontSize: 32,
            color: darktheme ? Colors.black : Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (BuildContext context) {
              _scaffoldContext = context;
              return IconButton(
                onPressed: _openDrawer,
                icon: Icon(
                  Icons.view_sidebar,
                  color: darktheme ? Colors.black : Colors.white,
                ),
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: darktheme ? Colors.black : Colors.white,
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: darktheme ? Colors.white : Colors.black,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: darktheme ? Colors.black : Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.privacy_tip,
                    color: darktheme ? Colors.white : Colors.black,
                  ),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                        color: darktheme ? Colors.white : Colors.black),
                  ),
                ],
              ),
              onTap: () {
                _launchPPURL(
                    "https://www.freeprivacypolicy.com/live/7b93da92-6ea5-4f9c-8465-61432792873d");
              },
            ),
            ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.delete_forever,
                      color: darktheme ? Colors.white : Colors.black,
                    ),
                    Text(
                      'Reset Data',
                      style: TextStyle(
                          color: darktheme ? Colors.white : Colors.black),
                    ),
                  ],
                ),
                onTap: () {
                  clearData();
                }),
          ],
        ),
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

  void _launchPPURL(String url) async {
    Uri url = Uri.parse(
        'https://www.freeprivacypolicy.com/live/7b93da92-6ea5-4f9c-8465-61432792873d');
    if (await launchUrl(url)) {
      //browser opened
    } else {
      SnackBar(content: Text("couldn't launch the page"));
    }
  }
}
