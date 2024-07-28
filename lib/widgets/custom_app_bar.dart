import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './dialogs/add_task_dialog.dart';
import './modals/completed_task_modal.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({Key? key, required this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        if (actions != null) ...actions!,
        IconButton(
          icon: const Icon(Icons.history),
          onPressed: () {
            showCompletedTasksBottomSheet(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => showAddTaskDialog(context),
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(123, 148, 238, 1),
              Color.fromRGBO(200, 190, 250, 1),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
