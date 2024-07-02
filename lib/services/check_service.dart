import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goal_grow_flutter/firebase_options.dart';
import 'package:goal_grow_flutter/models/check.dart';

class CheckService extends ChangeNotifier {
  List<Check> checks = [];

  CheckService() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseFirestore.instance
        .collection('check')
        .snapshots()
        .listen((snapshot) {
      checks = [];
      for (final document in snapshot.docs) {
        checks.add(Check(
          id: document.id,
          goalId: document.data()['goalId'],
          createdAt: document.data()['createdAt'].toDate(),
          amount: document.data()['amount'].toDouble(),
        ));
      }

      notifyListeners();
    });
  }

  static Future<DocumentReference> createCheck(Check check) async {
    return FirebaseFirestore.instance.collection("check").add(<String, dynamic>{
      'goalId': check.goalId,
      'createdAt': Timestamp.fromDate(check.createdAt),
      'amount': check.amount,
    });
  }
}