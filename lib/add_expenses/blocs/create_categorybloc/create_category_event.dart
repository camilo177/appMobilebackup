part of 'create_category_bloc.dart';

sealed class CreateCategoryEvent extends Equatable {
  const CreateCategoryEvent();

  @override
  List<Object> get props => [];
}

final class CreateCategoryRequested extends CreateCategoryEvent {
  final Category category;

  const CreateCategoryRequested(this.category);

  @override
  List<Object> get props => [category];
}
