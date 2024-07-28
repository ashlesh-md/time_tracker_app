import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';
import '../../screens/timer_main_content.dart';
import '../../utils/format_time.dart';
import '../custom_app_bar.dart';
import '../modals/options_modal.dart';

class TimerHeaderContent extends StatelessWidget {
  const TimerHeaderContent({
    Key? key,
    required this.widget,
    required this.hasTimeSpent,
  }) : super(key: key);

  final TimerMainContent widget;
  final bool hasTimeSpent;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [...widget.gradients],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        children: [
          CustomAppBar(
            title: 'Time Tracker',
          ),
          Text(
            widget.title,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Center(
            child: Text(
              formatTime(taskProvider.currentTask.timespent),
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${taskProvider.currentTask.content}',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    modalBottomSheetMenu(context);
                  },
                  child: Icon(
                    hasTimeSpent ? Icons.more_time : Icons.access_time,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
