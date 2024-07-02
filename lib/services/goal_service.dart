import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goal_grow_flutter/firebase_options.dart';
import 'package:goal_grow_flutter/models/goal.dart';

class GoalService extends ChangeNotifier {
  List<Goal> goals = [];

  GoalService() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseFirestore.instance
        .collection('goal')
        .snapshots()
        .listen((snapshot) {
      goals = [];
      for (final document in snapshot.docs) {
        goals.add(Goal(
          id: document.id,
          title: document.data()['title'],
          description: document.data()['description'],
          startDate: document.data()['startDate'].toDate(),
        ));
      }

      notifyListeners();
    });
  }

  static Future<DocumentReference> createGoal(Goal goal) async {
    return FirebaseFirestore.instance.collection("goal").add(<String, dynamic>{
      'title': goal.title,
      'description': goal.description,
      'startDate': Timestamp.fromDate(goal.startDate),
    });
  }
}
