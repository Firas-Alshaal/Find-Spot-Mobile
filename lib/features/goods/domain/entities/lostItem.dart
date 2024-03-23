import 'package:equatable/equatable.dart';
import 'package:lost_find_tracker/features/auth/data/models/user_model.dart';
import 'package:lost_find_tracker/features/goods/data/models/category_model.dart';

class LostItem with EquatableMixin {
  const LostItem({
    required this.name,
    required this.date,
    required this.city,
    required this.street,
    required this.categoryId,
    required this.description,
    this.images,
    this.category,
    this.lat,
    this.long,
    this.location,
    this.userId,
    this.id,
    this.isLost,
    this.user,
  });

  final String name;
  final String date;
  final String categoryId;
  final String? userId;
  final String? id;
  final double? lat;
  final double? long;
  final bool? isLost;
  final CategoryModel? category;
  final UserModel? user;
  final String city;
  final String street;
  final String description;
  final List<dynamic>? images;
  final List<double>? location;

  @override
  List<Object?> get props => [
        name,
        date,
        lat,
        long,
        description,
        categoryId,
        city,
        street,
        images,
        location,
        userId,
        category,
        id,
        isLost,
        user,
      ];
}
