import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repo/expense_repo.dart';
import 'package:flutter/material.dart';

part 'get_expenses_event.dart';
part 'get_expenses_state.dart';

class GetExpensesBloc extends Bloc<GetExpensesEvent, GetExpensesState> {
  final ExpenseRepo expenseRepo;

  GetExpensesBloc(this.expenseRepo) : super(GetExpensesInitial()) {
    on<GetExpenses>(_onGetExpenses);
  }

  Future<void> _onGetExpenses(GetExpenses event, Emitter<GetExpensesState> emit) async {
    emit(GetExpensesLoading());
    try {
      final expenses = await expenseRepo.getExpenses();
      emit(GetExpensesSuccess(expenses));
    } catch (e) {
      debugPrint('Error in GetExpensesBloc: $e'); // Log error
      emit(GetExpensesFailure());
    }
  }
}
