import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/timer/timer_button_content.dart';
import '../widgets/timer/timer_header_content.dart';

class TimerMainContent extends StatefulWidget {
  final List<Color> gradients;
  final String title;

  const TimerMainContent(
      {Key? key, required this.gradients, required this.title})
      : super(key: key);

  @override
  _TimerMainContentState createState() => _TimerMainContentState();
}

class _TimerMainContentState extends State<TimerMainContent> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);
        taskProvider.setTimer(_seconds);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _toggleTimer() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    setState(() {
      if (_isRunning) {
        _stopTimer();
        taskProvider.setTimer(_seconds);
      } else {
        _seconds = taskProvider.currentTask.timespent;
        _startTimer();
      }
      _isRunning = !_isRunning;
    });
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final hasTimeSpent = taskProvider.currentTask.timespent > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              TimerHeaderContent(widget: widget, hasTimeSpent: hasTimeSpent),
              Positioned(
                bottom: -110,
                left: MediaQuery.of(context).size.width / 2 - 110,
                child: GestureDetector(
                  onTap: _toggleTimer,
                  child:
                      TimerButtonContent(widget: widget, isRunning: _isRunning),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
