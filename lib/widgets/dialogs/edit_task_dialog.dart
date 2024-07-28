import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';
import './customs/custom_dialog.dart';
import './customs/custom_textfield.dart';

void editTaskDialog(BuildContext context) {
  final TextEditingController contentController = TextEditingController(
    text: Provider.of<TaskProvider>(context, listen: false).currentTask.content,
  );
  final TextEditingController descriptionController = TextEditingController(
    text: Provider.of<TaskProvider>(context, listen: false)
        .currentTask
        .description,
  );

  showDialog(
    context: context,
    builder: (context) {
      return CustomDialog(
        title: 'Edit Task',
        content: [
          CustomTextField(
            controller: contentController,
            labelText: 'Task Content',
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: descriptionController,
            labelText: 'Task Description',
          ),
        ],
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).editTask(
                Provider.of<TaskProvider>(context, listen: false)
                    .currentTask
                    .id!,
                contentController.text,
                descriptionController.text,
              );
              Navigator.of(context).pop();
            },
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}
