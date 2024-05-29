part of 'create_expense_bloc.dart';

abstract class CreateExpenseEvent extends Equatable {
  const CreateExpenseEvent();

  @override
  List<Object> get props => [];
}

class CreateExpenseRequested extends CreateExpenseEvent {
  final ExpenseEntity expense;

  const CreateExpenseRequested(this.expense);

  @override
  List<Object> get props => [expense];
}
