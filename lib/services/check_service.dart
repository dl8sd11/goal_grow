
import 'package:goal_grow_flutter/models/check.dart';

class CheckService {
  static Future<List<Check>> fetchChecks() async {
    return [
      Check(id: 1, goalId: 1, createdAt: DateTime.now(), amount: 300),
      Check(id: 2, goalId: 1, createdAt: DateTime.now(), amount: 100),
      Check(id: 3, goalId: 1, createdAt: DateTime.now(), amount: 50),
    ];
  }
}