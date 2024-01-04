import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/presentation/utilities/button.dart';
import 'package:to_do/presentation/utilities/snackbar.dart';

class DialogueBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final bool isDarkTheme;

  DialogueBox({
    Key? key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
    required this.isDarkTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isDarkTheme ? Colors.white : Colors.black;
    Color textColor = isDarkTheme ? Colors.black : Colors.white;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add a Task',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: isDarkTheme
                          ? Colors.white
                          : Colors.black, // Set border color based on theme
                      style: BorderStyle.solid),
                ),
                hintText: 'Enter your task...',
                hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
              ),
              style: TextStyle(
                fontSize: 18,
                color: textColor,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: 'Save',
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Please enter a task',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor:
                            Colors.red, // Change the background color
                        duration: Duration(
                            seconds:
                                3), // Set the duration for how long the SnackBar will be displayed
                        behavior: SnackBarBehavior
                            .floating, // Change the SnackBar behavior
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ), // Add border radius
                      ));
                    } else {
                      onSave();
                    }
                  },
                ),
                SizedBox(width: 10),
                MyButton(
                  text: 'Cancel',
                  onPressed: onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
