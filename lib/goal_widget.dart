import 'package:flutter/material.dart';
import 'package:goal_grow_flutter/models/check.dart';
import 'package:goal_grow_flutter/models/progresses_of_day.dart';
import 'package:goal_grow_flutter/models/progress.dart';
import 'package:goal_grow_flutter/services/check_service.dart';
import 'package:goal_grow_flutter/services/goal_service.dart';
import 'package:provider/provider.dart';

class GoalWidget extends StatefulWidget {
  const GoalWidget({
    super.key,
  });

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Consumer2<GoalService, CheckService>(
        builder: (context, goalService, checkService, child) => ListView(
            children: ProgressesOfDay(DateTime.now(),
                    goals: goalService.goals, checks: checkService.checks)
                .report()
                .map((progress) => Card(
                      color: progress.total() > 0
                          ? colorScheme.primary
                          : colorScheme.surface,
                      child: ListTile(
                        textColor: progress.total() > 0
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface,
                        title: Text(progress.goal.title),
                        subtitle: Text(progress.report()),
                        dense: false,
                        onTap: () => showCheckDialog(progress, context),
                      ),
                    ))
                .toList()));
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
  late TextEditingController _amount_controller;
  late TextEditingController _quantity_controller;

  @override
  void initState() {
    super.initState();
    _amount_controller = TextEditingController();
    _quantity_controller = TextEditingController();
  }

  @override
  void dispose() {
    _amount_controller.dispose();
    _quantity_controller.dispose();
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
            TextField(
              controller: _amount_controller,
              decoration: const InputDecoration(hintText: "amount: 5kg"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _quantity_controller,
              decoration: const InputDecoration(hintText: "quantity: 5reps"),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    for (int i = 0;
                        i < (int.tryParse(_quantity_controller.text) ?? 1);
                        i++) {
                      CheckService.createCheck(Check(
                          id: "",
                          goalId: widget.progress.goal.id,
                          createdAt: DateTime.now(),
                          amount:
                              (double.tryParse(_amount_controller.text)) ?? 1));
                    }
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
