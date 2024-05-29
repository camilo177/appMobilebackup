import 'package:coinapp/screens/home/views/chart.dart';
import 'package:expense_repo/expense_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatScreen extends StatelessWidget {
  final List<ExpenseEntity> expenses;

  const StatScreen({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Transactions',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 350,
              child: MyChart(expenses: expenses),
            ),
          ],
        ),
      ),
    );
  }
}
