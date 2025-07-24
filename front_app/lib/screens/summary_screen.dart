// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/expense_provider.dart';
// import '../widgets/chart_widget.dart';

// class SummaryScreen extends StatefulWidget {
//   const SummaryScreen({super.key});

//   @override
//   State<SummaryScreen> createState() => _SummaryScreenState();
// }

// class _SummaryScreenState extends State<SummaryScreen> {
//   String _period = 'daily';

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<ExpenseProvider>(context, listen: false).loadSummary(_period);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ExpenseProvider>(context);
//     return Column(
//       children: [
//         DropdownButton<String>(
//           value: _period,
//           onChanged: (val) {
//             setState(() => _period = val!);
//             provider.loadSummary(_period);
//           },
//           items: ['daily', 'weekly', 'monthly']
//               .map((e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase())))
//               .toList(),
//         ),
//         Expanded(child: ChartWidget(expenses: provider.expenses)),
//       ],
//     );
//   }
// }


// lib/screens/summary_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/chart_widget.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  String _selectedPeriod = 'daily';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseProvider>(context, listen: false).loadSummary(_selectedPeriod);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);

    return Column(
      children: [
        DropdownButton<String>(
          value: _selectedPeriod,
          onChanged: (value) {
            setState(() => _selectedPeriod = value!);
            provider.loadSummary(_selectedPeriod);
          },
          items: ['daily', 'weekly', 'monthly']
              .map((e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase())))
              .toList(),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: provider.expenses.isEmpty
              ? const Center(child: Text('No data available'))
              : ChartWidget(expenses: provider.expenses),
        ),
      ],
    );
  }
}
