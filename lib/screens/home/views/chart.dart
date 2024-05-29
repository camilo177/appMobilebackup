import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_repo/expense_repo.dart';

class MyChart extends StatefulWidget {
  final List<ExpenseEntity> expenses;

  const MyChart({super.key, required this.expenses});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 21, 92),
        title: const Text(
          'The summary of your transactions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0, 4),
                blurRadius: 8.0,
              ),
            ],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final Map<String, double> categoryTotals = {};

    for (var expense in widget.expenses) {
      categoryTotals.update(
        expense.category.name,
        (value) => value + expense.amount.toDouble(),
        ifAbsent: () => expense.amount.toDouble(),
      );
    }

    final categories = categoryTotals.keys.toList();
    return List.generate(categories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: _getColor(i),
        value: categoryTotals[categories[i]]!,
        title: categoryTotals[categories[i]]!.toStringAsFixed(0),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgeWidget: _Badge(
          iconData: CupertinoIcons.circle_fill,
          size: widgetSize,
          borderColor: const Color.fromARGB(255, 1, 21, 92),
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }

  Color _getColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xff0293ee);
      case 1:
        return const Color(0xfff8b250);
      case 2:
        return const Color(0xff845bef);
      case 3:
        return const Color(0xff13d38e);
      case 4:
        return const Color(0xffdc3545);
      default:
        return Colors.grey;
    }
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.iconData,
    required this.size,
    required this.borderColor,
  });

  final IconData iconData;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          iconData,
          size: size * 0.6,
          color: const Color.fromARGB(255, 1, 21, 92),
        ),
      ),
    );
  }
}
