import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext?)? deleteFunction;
  final Color backgroundColor;
  final Color textColor;

  ToDoTile({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(15),
            onPressed: deleteFunction,
            icon: Icons.delete_sweep_sharp,
            backgroundColor: const Color.fromARGB(255, 255, 17, 0),
          )
        ]),
        child: Container(
          decoration: BoxDecoration(
            color: textColor, // Use textColor for the background
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal:15,vertical: 3),
          child: Row(
            children: [
              Container(
                width: 24, // Adjust the width of the checkbox container
                height: 24, // Adjust the height of the checkbox container
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: backgroundColor == Colors.white
                        ? Colors.white // Black border for white background
                        : Colors.black, // Transparent border for other backgrounds
                  ),
                ),
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.amber, // Use amber color when selected
                  side: BorderSide.none,
                  checkColor: Colors.white,
                  fillColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.amber;
                      }
                      return Colors.transparent;
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  style: GoogleFonts.suezOne(
                    fontSize: taskCompleted ? 16 : 19,
                    color: backgroundColor, // Use backgroundColor for the text color
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 8),
                    child: Text(
                      taskName,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
