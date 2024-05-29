import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repo/expense_repo.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  final ExpenseRepo expenseRepo;

  CreateExpenseBloc(this.expenseRepo) : super(CreateExpenseInitial()) {
    on<CreateExpenseRequested>(_onCreateExpenseRequested);
  }

  Future<void> _onCreateExpenseRequested(CreateExpenseRequested event, Emitter<CreateExpenseState> emit) async {
    emit(CreateExpenseLoading());
    try {
      await expenseRepo.createExpense(event.expense);
      emit(CreateExpenseSuccess());
    } catch (e) {
      emit(CreateExpenseFailure());
    }
  }
}

