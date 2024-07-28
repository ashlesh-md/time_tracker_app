import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';
import '../../utils/format_time.dart';
import '../comments/comments_list.dart';
import '../dialogs/edit_task_dialog.dart';

void modalBottomSheetMenu(BuildContext context) {
  final taskProvider = Provider.of<TaskProvider>(context, listen: false);

  void _showCompletedPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green.shade200,
                  size: 50,
                ),
                const SizedBox(height: 10),
                Text(
                  'Completed',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (builder) {
      return Container(
        height: 400.0,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Task Options',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.access_time, color: Colors.blue.shade400),
              title: Text(
                'Time spent: ${formatTime(taskProvider.currentTask.timespent)}',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              ),
              onTap: () {
                // Implement time spent logic
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red.shade400),
              title: Text(
                'Delete',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              ),
              onTap: () {
                taskProvider.deleteTask();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.comment, color: Colors.orange.shade400),
              title: Text(
                'See Comment',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CommentList(
                      taskId: taskProvider.currentTask.id!,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.edit, color: Colors.green.shade400),
              title: Text(
                'Edit',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              ),
              onTap: () {
                editTaskDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.done, color: Colors.green.shade400),
              title: Text(
                'Complete',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              ),
              onTap: () {
                taskProvider.completeTask();
                Navigator.of(context).pop();
                _showCompletedPopup();
              },
            ),
          ],
        ),
      );
    },
  );
}
