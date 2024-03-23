import 'package:lost_find_tracker/features/auth/data/models/user_model.dart';
import 'package:lost_find_tracker/features/goods/data/models/category_model.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';

class LostItemModel extends LostItem {
  const LostItemModel({
    required String name,
    required String description,
    required String date,
    required String categoryId,
    required String city,
    required String street,
    String? id,
    String? userId,
    List<double>? location,
    double? lat,
    double? long,
    List<dynamic>? images,
    bool? isLost,
    final UserModel? user,
    final CategoryModel? category,
  }) : super(
            name: name,
            description: description,
            lat: lat,
            long: long,
            date: date,
            categoryId: categoryId,
            city: city,
            street: street,
            userId: userId,
            id: id,
            user: user,
            location: location,
            category: category,
            isLost: isLost,
            images: images);

  factory LostItemModel.fromJson(Map<String, dynamic> json) {
    return LostItemModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      lat: json['lat'],
      long: json['long'],
      userId: json['user_id'],
      date: json['lost_date'],
      categoryId: json['category_id'],
      city: json['city'],
      street: json['street'],
      isLost: json['is_lost'],
      category: CategoryModel.fromJson(json['category']),
      user: UserModel.fromJson(json['user']),
      images: List.castFrom<dynamic, String>(json['images']),
      location: List.castFrom<dynamic, double>(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'lost_date': date,
      'category_id': categoryId,
      'lat': lat,
      'long': long,
      'city': city,
      'street': street,
      'images': images,
      'user_id': userId,
      'is_lost': isLost,
      'location': location,
      'category': category!.toJson(),
      'user': user!.toJson(),
    };
  }
}
