import 'package:flutter/material.dart';
import 'package:goal_grow_flutter/models/goal.dart';
import 'package:goal_grow_flutter/services/goal_service.dart';

class CreateGoalWidget extends StatefulWidget {
  const CreateGoalWidget({
    super.key,
  });

  @override
  State<CreateGoalWidget> createState() => _CreateGoalWidgetState();
}

class _CreateGoalWidgetState extends State<CreateGoalWidget> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
                labelText: "Title", hintText: "Example: drink water"),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
                labelText: "Description",
                hintText: "Example: I drank ? mL of water."),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    GoalService.createGoal(Goal(
                        id: "",
                        title: _titleController.text,
                        startDate: DateTime.now(),
                        description: _descriptionController.text)).then((value) {
                          _titleController.clear();
                          _descriptionController.clear();
                        });
                  },
                  child: const Text("Create")),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Clear"))
            ],
          )
        ],
      ),
    );
  }
}
