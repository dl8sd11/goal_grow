import 'package:flutter/material.dart';
import 'package:goal_grow_flutter/analysis_widget.dart';
import 'package:goal_grow_flutter/create_goal_widget.dart';
import 'package:goal_grow_flutter/goal_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:goal_grow_flutter/services/check_service.dart';
import 'package:goal_grow_flutter/services/goal_service.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => GoalService(),
      ),
      ChangeNotifierProvider(
        create: (context) => CheckService(),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.today)),
                Tab(icon: Icon(Icons.plus_one)),
                Tab(icon: Icon(Icons.analytics)),
              ],
            ),
            title: const Text('Goal Grow'),
          ),
          body: const TabBarView(
            children: [
              GoalWidget(),
              CreateGoalWidget(),
              AnalysisWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
