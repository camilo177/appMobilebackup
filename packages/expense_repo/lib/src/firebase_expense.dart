import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../expense_repo.dart';

class FirebaseExpense implements ExpenseRepo {
  final categoryCollection = FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Future<void> createCategory(Category category) async {
    try {
      await categoryCollection.doc(category.categoryId).set(category.toEntity().toDocument());
    } catch (e) {
      debugPrint('Error creating category: $e');
      throw e;
    }
  }

    @override
  Future<List<Category>> getCategory() async {
    try {
      return await categoryCollection.get().then((value) => value.docs.map((e) => Category.fromEntity(CategoryEntity.fromDocument(e.data()))).toList());
    } catch (e) {
      debugPrint('Error creating category: $e');
      throw e;
    }
  }

    @override
  Future<void> createExpense(ExpenseEntity expense) async {
    try {
      await expenseCollection.doc(expense.expenseId).set(expense.toDocument());
    } catch (e) {
      debugPrint('Error creating expense: $e');
      throw e;
    }
  }

  @override
  Future<List<ExpenseEntity>> getExpenses() async {
    try {
      final snapshot = await expenseCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ExpenseEntity.fromDocument(data);
      }).toList();
    } catch (e) {
      debugPrint('Error fetching expenses: $e');
      throw e;
    }
  }
}

