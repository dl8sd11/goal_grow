import 'package:flutter/material.dart';
import 'package:goal_grow_flutter/models/check.dart';
import 'package:goal_grow_flutter/models/goal.dart';
import 'package:goal_grow_flutter/models/progress.dart';

class DailyProgress {
  final List<Goal> goals;
  final List<Check> checks;
  final DateTime date;

  DailyProgress(this.date, {required this.goals, required this.checks});

  List<Progress> report() {
    List<Progress> progresses = [];
    for (Goal goal in goals) {
      progresses.add(Progress(
          goal: goal,
          checks: checks
              .where((element) =>
                  DateUtils.isSameDay(date, element.createdAt) &&
                  element.goalId == goal.id)
              .toList()));
    }
    return progresses;
  }
}
