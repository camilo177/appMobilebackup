import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repo/expense_repo.dart';
import '../models/models.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  DateTime date;
  int amount;

  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
  });

  // Converts an ExpenseEntity instance to a Map<String, dynamic> document
  Map<String, dynamic> toDocument() {
    return {
      'expenseId': expenseId,
      'category': category.toEntity().toDocument(),  
      'date': date,  
      'amount': amount,
    };
  }

  // Creates an ExpenseEntity instance from a Map<String, dynamic> document
  static ExpenseEntity fromDocument(Map<String, dynamic> document) {
    return ExpenseEntity(
      expenseId: document['expenseId'],
      category: Category.fromEntity(CategoryEntity.fromDocument(document['category'])),  
      date: (document['date'] as Timestamp).toDate(),  // Fixed your error here
      amount: document['amount'],
    );
  }
}
