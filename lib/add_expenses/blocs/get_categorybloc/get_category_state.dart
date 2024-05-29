part of 'get_category_bloc.dart';

sealed class GetCategoryState extends Equatable {
  const GetCategoryState();
  
  @override
  List<Object> get props => [];
}

final class GetCategoryInitial extends GetCategoryState {}
