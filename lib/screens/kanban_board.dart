import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/tasks/task_card.dart';
import 'timer_main_content.dart';

class KanbanBoard extends StatefulWidget {
  const KanbanBoard({Key? key}) : super(key: key);

  @override
  _KanbanBoardState createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
    _fetchTasks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchTasks() async {
    try {
      await Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildKanbanColumn(taskProvider.toDo, Colors.indigo.shade300,
                    gradients[0], 'To Do'),
                buildKanbanColumn(taskProvider.inProgress, Colors.pink.shade300,
                    gradients[1], 'In Progress'),
                buildKanbanColumn(taskProvider.done, Colors.green.shade300,
                    gradients[2], 'Done'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildKanbanColumn(
      List<Task> tasks, Color color, List<Color> gradient, String title) {
    var gr = gradient;

    final taskProvider = Provider.of<TaskProvider>(context);

    return SizedBox(
      width: 300,
      child: DragTarget<Task>(
        onAccept: (task) {
          setState(() {
            for (var list in [
              taskProvider.toDo,
              taskProvider.inProgress,
              taskProvider.done
            ]) {
              if (list.contains(task)) {
                list.remove(task);
                break;
              }
            }
            tasks.add(task);
          });
        },
        builder: (context, candidateData, rejectedData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TimerMainContent(
                  title: title,
                  gradients: [...gr],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return GestureDetector(
                      onTap: () {
                        Provider.of<TaskProvider>(context, listen: false)
                            .setCurrentTask(tasks[index]);
                      },
                      child: Draggable<Task>(
                        data: task,
                        feedback: Material(
                          child: TaskCard(task: task, color: color),
                        ),
                        childWhenDragging: Container(),
                        child: TaskCard(task: task, color: color),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
