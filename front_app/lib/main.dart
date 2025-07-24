
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/expense_provider.dart';
import 'screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  
  runApp(const ExpenseApp());
  
}


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // optional but recommended for async main
//   await dotenv.load(fileName: ".env");
//   runApp(const ExpenseApp());
// }

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      
      create: (_) => ExpenseProvider(),
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false, 
      ),
    );
  }
}
