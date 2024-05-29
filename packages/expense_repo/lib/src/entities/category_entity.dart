class CategoryEntity {
  String categoryId;
  String name;
  double totalExpenses;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
  });

  Map<String, dynamic> toDocument() {
    return {
      'categoryId': categoryId,
      'name': name,
      'totalExpenses': totalExpenses,
    };
  }

  static CategoryEntity fromDocument(Map<String, dynamic> document) {
    return CategoryEntity(
      categoryId: document['categoryId'],
      name: document['name'],
      totalExpenses: document['totalExpenses'],
    );
  }
}
