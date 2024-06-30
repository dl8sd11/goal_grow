import 'package:flutter/material.dart';
import 'package:goal_grow_flutter/goal_widget.dart';

void main() {
  runApp(const MainApp());
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
              Icon(Icons.plus_one),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
