import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';
import './customs/custom_dialog.dart';
import './customs/custom_textfield.dart';

void showAddTaskDialog(BuildContext context) {
  final TextEditingController taskContentController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return CustomDialog(
        title: 'Add New Task',
        content: [
          CustomTextField(
            controller: taskContentController,
            labelText: 'Task Content',
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: taskDescriptionController,
            labelText: 'Task Description',
          ),
        ],
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final taskContent = taskContentController.text.trim();
              final taskDescription = taskDescriptionController.text.trim();
              if (taskContent.isNotEmpty) {
                await Provider.of<TaskProvider>(context, listen: false)
                    .addTask(taskContent, taskDescription);
                taskContentController.clear();
                taskDescriptionController.clear();
                Navigator.pop(context); // Close the dialog
              }
            },
            child: Text(
              'Add Task',
              style: GoogleFonts.poppins(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}
