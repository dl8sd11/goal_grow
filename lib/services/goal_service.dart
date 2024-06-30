import 'package:goal_grow_flutter/models/goal.dart';

class GoalService {
  // Replace with your actual API endpoint
  static const String baseUrl = 'https://your-api.com/goals';

  static Future<List<Goal>> fetchGoals() async {
    return [
      Goal(
          id: 1,
          title: "drink water",
          startDate: DateTime(2002, 6, 7, 5, 0),
          description: "I drank ? mL of water today."),
      Goal(
          id: 2,
          title: "pushups",
          startDate: DateTime(2002, 6, 7, 5, 0),
          description: "I did ? push-ups today."),
      Goal(
          id: 3,
          title: "read",
          startDate: DateTime(2002, 6, 7, 5, 0),
          description: "I read ? minutes today."),
      Goal(
          id: 4,
          title: "drink water",
          startDate: DateTime(2002, 6, 7, 5, 0),
          description: "I drank ? mL of water today."),
      Goal(
          id: 5,
          title: "pushups",
          startDate: DateTime(2002, 6, 7, 5, 0),
          description: "I did ? push-ups today."),
      Goal(
          id: 6,
          title: "read",
          startDate: DateTime(2002, 6, 7, 5, 0),
          description: "I read ? minutes today."),
      Goal(
          id: 7,
          title: "drink water",
          startDate: DateTime(2002, 6, 7, 5, 0),
          description: "I drank ? mL of water today."),
      Goal(
          id: 8,
          title: "pushups",
          startDate: DateTime(2002, 6, 7, 5, 0),
          description: "I did ? push-ups today."),
      Goal(
          id: 9,
          title: "read",
          startDate: DateTime(2002, 6, 7, 5, 0),
          description: "I read ? minutes today."),
      Goal(
          id: 10,
          title: "read",
          startDate: DateTime(2002, 6, 7, 5, 0),
          description: "I read ? minutes today."),
    ];
  }

  static Future<Goal> createGoal(Goal goal) async {
    return goal;
  }

  static Future<Goal> updateGoal(Goal goal) async {
    return goal;
  }

  static Future<void> deleteGoal(int id) async {
    return;
  }
}
