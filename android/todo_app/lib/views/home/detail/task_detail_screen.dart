import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/viewmodel/task_category_viewmodel.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String taskCategories;
  late String priority;
  late String status;
  late String dueDate;
  TimeOfDay? dueTime;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
    taskCategories = widget.task.categoryId?.toString() ?? '';
    priority = widget.task.priority;
    status = widget.task.status;
    dueDate = DateTime.fromMillisecondsSinceEpoch(widget.task.dueDate!)
        .toIso8601String();
    dueTime = widget.task.dueDate != null
        ? TimeOfDay(
            hour:
                DateTime.fromMillisecondsSinceEpoch(widget.task.dueDate!).hour,
            minute: DateTime.fromMillisecondsSinceEpoch(widget.task.dueDate!)
                .minute,
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<TaskViewmodel>(
        builder: (context, TaskViewmodel value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.task_detail),
          actions: [
            IconButton(
              onPressed: () {
                value.deleteTask(widget.task.id!);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: l10n.task_title,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: l10n.task_description,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Consumer<TaskCategoryViewmodel>(builder: (context, value, child) {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: l10n.category,
                    border: const OutlineInputBorder(),
                  ),
                  value: taskCategories.isNotEmpty ? taskCategories : null,
                  items: value.taskCategories.isNotEmpty
                      ? value.taskCategories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id.toString(),
                            child: Text(category.name.toUpperCase()),
                          );
                        }).toList()
                      : [],
                  onChanged: (value) {
                    taskCategories = value!;
                  },
                );
              }),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: l10n.priority,
                  border: const OutlineInputBorder(),
                ),
                value: priority,
                items: ['low', 'medium', 'high'].map((String priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  priority = value!;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: l10n.status,
                  border: const OutlineInputBorder(),
                ),
                value: status,
                items: ['pending', 'in_progress', 'completed']
                    .map((String status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.replaceAll('_', ' ').toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  status = value!;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(l10n.due_date),
                subtitle: dueDate.isNotEmpty
                    ? Text(DateTime.parse(dueDate).toString().split(' ')[0])
                    : null,
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: dueDate.isNotEmpty
                        ? DateTime.parse(dueDate)
                        : DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      dueDate = picked.toIso8601String();
                    });
                  }
                },
              ),
              ListTile(
                title: Text(l10n.due_date),
                trailing: const Icon(Icons.timer_sharp),
                subtitle:
                    dueTime != null ? Text(dueTime!.format(context)) : null,
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: dueTime ?? TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      dueTime = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  DateTime? finalDateTime;
                  if (dueDate.isNotEmpty) {
                    final date = DateTime.parse(dueDate);
                    if (dueTime != null) {
                      finalDateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        dueTime!.hour,
                        dueTime!.minute,
                      );
                    } else {
                      finalDateTime = date;
                    }
                  }

                  await value.updateTask(
                    Task(
                      id: widget.task.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      dueDate: finalDateTime?.millisecondsSinceEpoch,
                      priority: priority,
                      status: status,
                      categoryId: taskCategories.isNotEmpty
                          ? int.parse(taskCategories)
                          : null,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(l10n.save),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
