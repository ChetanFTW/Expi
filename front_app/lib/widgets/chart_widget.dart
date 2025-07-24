// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import '../models/expense_model.dart';

// class ChartWidget extends StatelessWidget {
//   final List<Expense> expenses;

//   const ChartWidget({super.key, required this.expenses});

//   @override
//   Widget build(BuildContext context) {
//     final categoryTotals = <String, double>{};
//     for (var e in expenses) {
//       categoryTotals[e.category] = (categoryTotals[e.category] ?? 0) + e.amount;
//     }

//     final sections = categoryTotals.entries
//         .map((e) => PieChartSectionData(
//               title: e.key,
//               value: e.value,
//               radius: 60,
//               titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//             ))
//         .toList();

//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: PieChart(PieChartData(sections: sections)),
//     );
//   }
// }




// lib/widgets/chart_widget.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/expense_model.dart';

class ChartWidget extends StatelessWidget {
  final List<Expense> expenses;

  const ChartWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> categoryData = {};
    for (var e in expenses) {
      categoryData[e.category] = (categoryData[e.category] ?? 0) + e.amount;
    }

    final List<PieChartSectionData> sections = categoryData.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        radius: 60,
        titleStyle: const TextStyle(fontSize: 14),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: PieChart(PieChartData(
        sections: sections,
        sectionsSpace: 4,
        centerSpaceRadius: 40,
      )),
    );
  }
}
