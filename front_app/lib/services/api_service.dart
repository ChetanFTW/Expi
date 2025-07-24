

// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/expense_model.dart';



class ApiService {

  static const String baseUrl = 'http://10.0.2.2:8000'; // for Android emulator


  // Future<void> postExpense(Expense expense) async {
  //   final url = Uri.parse('$baseUrl/expenses'); // ✅ Correct path
  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(expense.toJson()),
  //   );

  //   if (response.statusCode != 200 && response.statusCode != 201) {
  //     print('Failed POST: ${response.body}');
  //     throw Exception('Failed to post expense');
  //   }
  // }

  Future<void> postExpense(Expense expense) async {
  final url = Uri.parse('$baseUrl/expenses');
  final body = jsonEncode(expense.toJson());

  print('Posting to $url: $body');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: body,
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode != 200 && response.statusCode != 201) {
    throw Exception('Failed to post expense: ${response.statusCode}');
  }
}

  

  Future<List<Expense>> getSummary(String period) async {
    final url = Uri.parse('$baseUrl/expenses/summary?period=$period'); // ✅ Correct path
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Expense.fromJson(e)).toList();
    } else {
      print('Failed GET: ${response.body}');
      throw Exception('Failed to load summary');
    }
  }
}
