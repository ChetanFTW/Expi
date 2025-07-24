import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../services/api_service.dart';

class ExpenseProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  Future<void> addExpense(Expense expense) async {
    await _apiService.postExpense(expense);
    _expenses.add(expense);
    notifyListeners();
  }

  Future<void> loadSummary(String period) async {
    _expenses = await _apiService.getSummary(period);
    notifyListeners();
  }
}
