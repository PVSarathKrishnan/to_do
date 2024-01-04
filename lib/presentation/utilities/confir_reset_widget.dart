import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/presentation/Screens/splash_screen.dart';

class ConfirmResetWidget extends StatelessWidget {
  const ConfirmResetWidget({
    Key? key,
    required this.mybox,
  }) : super(key: key);

  final Box mybox;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm Deletion"),
      content: Text("Are you sure you want to clear all data?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            mybox.clear(); // Clear the data using the 'mybox' property
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SplashScreen(),
            )); // Close the dialog
          },
          child: Text(
            "Confirm",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 255, 17, 0),
            ),
          ),
        ),
      ],
    );
  }
}
