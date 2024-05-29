import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repo/expense_repo.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  final ExpenseRepo expenseRepo;

  CreateCategoryBloc(this.expenseRepo) : super(CreateCategoryInitial()) {
    on<CreateCategoryRequested>((event, emit) async {
      emit(CreateCategoryLoading());
      try {
        await expenseRepo.createCategory(event.category);
        emit(CreateCategorySuccess());
      } catch (e) {
        emit(CreateCategoryFailure());
      }
    });
  }
}

