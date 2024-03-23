import 'package:equatable/equatable.dart';

class Search with EquatableMixin {
  const Search({
    required this.name,
    required this.location,
    required this.date,
    required this.categoryId,
  });

  final String date;
  final String categoryId;
  final String location;
  final String name;

  @override
  List<Object?> get props => [
        name,
        categoryId,
        location,
        date,
      ];
}
