import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskStatisticsScreen extends StatefulWidget {
  const TaskStatisticsScreen({super.key});

  @override
  State<TaskStatisticsScreen> createState() => _TaskStatisticsScreenState();
}

class _TaskStatisticsScreenState extends State<TaskStatisticsScreen> {
  DateTime _currentWeekStart =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));

  DateTime get _currentWeekEnd =>
      _currentWeekStart.add(const Duration(days: 6));

  void _goToPreviousWeek() {
    setState(() {
      _currentWeekStart = _currentWeekStart.subtract(const Duration(days: 7));
    });
  }

  void _goToNextWeek() {
    setState(() {
      _currentWeekStart = _currentWeekStart.add(const Duration(days: 7));
    });
  }

  String _formatWeekRange() {
    final start = '${_currentWeekStart.day}/${_currentWeekStart.month}';
    final end = '${_currentWeekEnd.day}/${_currentWeekEnd.month}';
    return '$start - $end';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statistics),
      ),
      body: Consumer<TaskViewmodel>(
        builder: (context, taskViewModel, child) {
          final tasks = taskViewModel.tasks;

          // Calculate completed vs incomplete tasks
          final completedTasks =
              tasks.where((task) => task.status == 'completed').length;
          final incompleteTasks =
              tasks.where((task) => task.status != 'completed').length;

          // Group tasks by day of week for current week
          final tasksByDay = <int, int>{};
          for (var task in tasks.where((task) => task.status == 'completed')) {
            if (task.dueDate != null &&
                DateTime.fromMillisecondsSinceEpoch(task.dueDate!).isAfter(
                    _currentWeekStart.subtract(const Duration(days: 1))) &&
                DateTime.fromMillisecondsSinceEpoch(task.dueDate!)
                    .isBefore(_currentWeekEnd.add(const Duration(days: 1)))) {
              final day =
                  DateTime.fromMillisecondsSinceEpoch(task.dueDate!).weekday;
              tasksByDay[day] = (tasksByDay[day] ?? 0) + 1;
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Task completion status pie chart
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          'Task Completion Status',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: completedTasks.toDouble(),
                                  title: '$completedTasks',
                                  color: Colors.green,
                                  radius: 100,
                                ),
                                PieChartSectionData(
                                  value: incompleteTasks.toDouble(),
                                  title: '$incompleteTasks',
                                  color: Colors.red,
                                  radius: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Completed tasks by day of week bar chart
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: _goToPreviousWeek,
                            ),
                            Text(
                              _formatWeekRange(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: _goToNextWeek,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: tasksByDay.values
                                      .fold(0, (p, c) => p > c ? p : c)
                                      .toDouble() +
                                  1,
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      const days = [
                                        'Mon',
                                        'Tue',
                                        'Wed',
                                        'Thu',
                                        'Fri',
                                        'Sat',
                                        'Sun'
                                      ];
                                      if (value >= 0 && value < days.length) {
                                        return Text(days[value.toInt()]);
                                      }
                                      return const Text('');
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      return Text(value.toInt().toString());
                                    },
                                  ),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: const FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: 1,
                              ),
                              barGroups: List.generate(7, (index) {
                                final day = index + 1; // 1 = Monday, 7 = Sunday
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: tasksByDay[day]?.toDouble() ?? 0,
                                      color: Colors.blue,
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Summary cards
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Text(
                                'Completed Tasks',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$completedTasks',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Text(
                                'Incomplete Tasks',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$incompleteTasks',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
