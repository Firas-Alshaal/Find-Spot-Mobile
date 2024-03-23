import 'package:lost_find_tracker/features/goods/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required String name,
    required String id,
  }) : super(name: name, id: id);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
