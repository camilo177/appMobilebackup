import '../entities/entities.dart';

class Category {
  String categoryId;
  String name;
  double totalExpenses;

  Category({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
  });

  static final empty = Category(
    categoryId: '',
    name: '',
    totalExpenses: 0,
  );


  CategoryEntity toEntity(){
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      totalExpenses: totalExpenses,
    );
  }

  static Category fromEntity(CategoryEntity entity){
    return Category(
      categoryId: entity.categoryId,
      name: entity.name,
      totalExpenses: entity.totalExpenses,
    );
  }
  
}