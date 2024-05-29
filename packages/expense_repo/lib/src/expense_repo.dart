import '../expense_repo.dart';

abstract class ExpenseRepo {
  Future<void> createCategory(Category category);
  Future <List<Category>> getCategory();
  Future<void> createExpense(ExpenseEntity expense);
  Future <List<ExpenseEntity>> getExpenses();
}