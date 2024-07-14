import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:goal_grow_flutter/models/check_filter.dart';
import 'package:goal_grow_flutter/models/progresses_of_goal.dart';
import 'package:goal_grow_flutter/services/check_service.dart';
import 'package:goal_grow_flutter/services/goal_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Color.fromARGB(26, 220, 20, 20);
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

class AnalysisWidget extends StatefulWidget {
  const AnalysisWidget({
    super.key,
  });

  @override
  State<AnalysisWidget> createState() => _AnalysisWidgetState();
}

class _AnalysisWidgetState extends State<AnalysisWidget> {
  String? selectedGoalId;

  @override
  Widget build(BuildContext context) {
    return Consumer2<GoalService, CheckService>(
        builder: (context, goalService, checkService, child) {
      final dropDownItems = goalService.goals
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.title),
              ))
          .toList();
      final selectedGoal = selectedGoalId != null
          ? goalService.goals
              .firstWhere((element) => element.id == selectedGoalId)
          : null;

      const millisecondsOfADay = 24 * 60 * 60 * 1000;

      List<FlSpot> spots = [];
      double bottomInterval = 1;
      if (selectedGoal != null) {
        var report = ProgressesOfGoal(
                goal: selectedGoal,
                checks: CheckFilter(checks: checkService.checks)
                    .filterByGoal(selectedGoal))
            .report();
        double dataWidth =
            (report.last.checks[0].createdAt.millisecondsSinceEpoch -
                report.first.checks[0].createdAt.millisecondsSinceEpoch) / millisecondsOfADay;
        bottomInterval = dataWidth / 2;
        spots = report
            .map((progress) => FlSpot(
                (progress.checks[0].createdAt.millisecondsSinceEpoch /
                        millisecondsOfADay)
                    .floor()
                    .toDouble(),
                progress.total()))
            .toList();
      }

      final ColorScheme colorScheme = Theme.of(context).colorScheme;

      List<Color> gradientColors = [
        colorScheme.primary,
        colorScheme.inversePrimary,
      ];

      return Column(
        children: [
          DropdownButton<String>(
              value: selectedGoalId,
              items: dropDownItems,
              onChanged: (String? selection) {
                setState(() {
                  selectedGoalId = selection;
                });
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 30),
              child: LineChart(
                duration: const Duration(milliseconds: 250),
                LineChartData(
                    titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          interval: bottomInterval,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) => SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(DateFormat("MMM-dd").format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    value.round() * millisecondsOfADay))),
                          ),
                        ))),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: 1,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: colorScheme.shadow.withOpacity(0.1),
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: colorScheme.shadow.withOpacity(0.1),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                            getTooltipColor: (spot) =>
                                colorScheme.primaryContainer)),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: gradientColors,
                        ),
                        barWidth: 5,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(
                          show: true,
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: gradientColors
                                .map((color) => color.withOpacity(0.3))
                                .toList(),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ],
      );
    });
  }
}
