// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/expense_model.dart';
// import '../providers/expense_provider.dart';

// class AddExpenseScreen extends StatefulWidget {
//   const AddExpenseScreen({super.key});

//   @override
//   State<AddExpenseScreen> createState() => _AddExpenseScreenState();
// }

// class _AddExpenseScreenState extends State<AddExpenseScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   final _descController = TextEditingController();
//   String _category = 'Food';
//   DateTime _date = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Form(
//         key: _formKey,
//         child: ListView(
//           children: [
//             TextFormField(
//               controller: _amountController,
//               decoration: const InputDecoration(labelText: 'Amount'),
//               keyboardType: TextInputType.number,
//               validator: (val) => val!.isEmpty ? 'Enter amount' : null,
//             ),
//             TextFormField(
//               controller: _descController,
//               decoration: const InputDecoration(labelText: 'Description'),
//             ),
//             DropdownButtonFormField(
//               value: _category,
//               items: ['Food', 'Transport', 'Groceries', 'Entertainment']
//                   .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                   .toList(),
//               onChanged: (val) => setState(() => _category = val!),
//               decoration: const InputDecoration(labelText: 'Category'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   final expense = Expense(
//                     amount: double.parse(_amountController.text),
//                     category: _category,
//                     description: _descController.text,
//                     date: _date,
//                   );
//                   await Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Expense added!')),
//                   );
//                 }
//               },
//               child: const Text('Add Expense'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// lib/screens/add_expense_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense_model.dart';
import '../providers/expense_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = 'Groceries';
  DateTime _selectedDate = DateTime.now();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newExpense = Expense(
        amount: double.parse(_amountController.text),
        category: _selectedCategory,
        description: _descController.text,
        date: _selectedDate,
      );

      try {
        await Provider.of<ExpenseProvider>(context, listen: false).addExpense(newExpense);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Expense added')),
        );
        _formKey.currentState!.reset();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              validator: (val) => val == null || val.isEmpty ? 'Enter amount' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items: ['Groceries', 'Food', 'Transport', 'Bills', 'Other']
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (val) => val == null || val.isEmpty ? 'Enter description' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("Date: ${_selectedDate.toLocal().toString().split(' ')[0]}"),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: _pickDate, child: const Text("Pick Date")),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
