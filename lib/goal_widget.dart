import 'package:flutter/material.dart';
import 'package:goal_grow_flutter/models/check.dart';
import 'package:goal_grow_flutter/models/daily_progress.dart';
import 'package:goal_grow_flutter/models/goal.dart';
import 'package:goal_grow_flutter/models/progress.dart';
import 'package:goal_grow_flutter/services/check_service.dart';
import 'package:goal_grow_flutter/services/goal_service.dart';

class GoalWidget extends StatefulWidget {
  const GoalWidget({
    super.key,
  });

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  List<Goal> goals = [];
  List<Check> checks = [];

  void fetchGoals() async {
    final fetchedGoals = await GoalService.fetchGoals();
    setState(() {
      goals = fetchedGoals;
    });
  }

  void fetchChecks() async {
    final fetchedChecks = await CheckService.fetchChecks();
    setState(() {
      checks = fetchedChecks;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchGoals();
    fetchChecks();
  }

  @override
  Widget build(BuildContext context) {
    final progresses =
        DailyProgress(DateTime.now(), goals: goals, checks: checks);
    return ListView(
        children: progresses
            .report()
            .map((progress) => Card(
                  child: ListTile(
                    title: Text(progress.goal.title),
                    subtitle: Text(progress.report()),
                    dense: false,
                    onTap: () => showCheckDialog(progress, context),
                  ),
                ))
            .toList());
  }

  Future<String?> showCheckDialog(Progress progress, BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => CheckDialog(progress: progress),
    );
  }
}

class CheckDialog extends StatefulWidget {
  final Progress progress;

  const CheckDialog({super.key, required this.progress});

  @override
  State<CheckDialog> createState() => _CheckDialogState();
}

class _CheckDialogState extends State<CheckDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Check in: ${widget.progress.goal.title}'),
            const SizedBox(height: 15),
            TextField(controller: _controller),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
