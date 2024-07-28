import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';

class CompletedTasksHistoryList extends StatelessWidget {
  const CompletedTasksHistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final completedTasksHistory = taskProvider.done;

        return ListView.builder(
          itemCount: completedTasksHistory.length,
          itemBuilder: (context, index) {
            final task = completedTasksHistory[index];
            return ListTile(
              title: Text(task.content ?? ''),
            );
          },
        );
      },
    );
  }
}
