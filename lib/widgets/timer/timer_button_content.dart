import 'package:flutter/material.dart';

import '../../screens/timer_main_content.dart';

class TimerButtonContent extends StatelessWidget {
  const TimerButtonContent({
    Key? key,
    required this.widget,
    required bool isRunning,
  })  : _isRunning = isRunning,
        super(key: key);

  final TimerMainContent widget;
  final bool _isRunning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [...widget.gradients],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isRunning ? Icons.pause : Icons.play_arrow_outlined,
              size: 100,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
