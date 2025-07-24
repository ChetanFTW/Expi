import 'package:flutter/material.dart';
import 'add_expense_screen.dart';
import 'summary_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Add'),
            Tab(text: 'Summary'),
          ]),
        ),
        body: const TabBarView(
          children: [
            AddExpenseScreen(),
            SummaryScreen(),
          ],
        ),
      ),
    );
  }
}
