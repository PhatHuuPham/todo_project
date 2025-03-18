import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/task_category_viewmodel.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:todo_app/views/home/detail/task_detail_screen.dart';
import 'package:todo_app/views/share/task_category_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with WidgetsBindingObserver {
  double containerCategorySize = 100;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.task), automaticallyImplyLeading: false),
      body: Column(
        children: [
          Center(
            child: Text(
              l10n.today,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Consumer<TaskViewmodel>(builder: (context, value, child) {
            final todayTasks = value.tasks
                .where((task) => value.isSameDate(
                    task.dueDate != null
                        ? DateTime.fromMillisecondsSinceEpoch(task.dueDate!)
                        : null,
                    DateTime.now()))
                .toList();

            return Expanded(
              child: ListView.builder(
                itemCount: todayTasks.length,
                itemBuilder: (context, index) {
                  final task = todayTasks[index];
                  return ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.status == 'completed'
                            ? TextDecoration.lineThrough
                            : null,
                        decorationThickness: 2,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailScreen(task: task),
                        ),
                      );
                    },
                    trailing: Checkbox(
                      value: task.status == 'completed',
                      onChanged: (bool? newValue) {
                        value.updateTaskStatus(task.id,
                            newValue == true ? 'completed' : 'in_progress');
                      },
                    ),
                  );
                },
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.task_categories,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      containerCategorySize =
                          (containerCategorySize == 100) ? 300 : 100;
                    });
                  },
                  icon: Icon(
                    containerCategorySize == 100
                        ? Icons.expand_less
                        : Icons.expand_more,
                  ),
                ),
              ],
            ),
          ),
          Consumer<TaskCategoryViewmodel>(
            builder: (context, value, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: containerCategorySize,
                child: ListView.builder(
                  itemCount: value.taskCategories.length,
                  itemBuilder: (context, index) {
                    final taskCategory = value.taskCategories[index];
                    return ListTile(
                      title: Text(taskCategory.name),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return TaskCategoryBottomSheet(
                                taskCategory: taskCategory);
                          },
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
