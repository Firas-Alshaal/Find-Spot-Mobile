import 'package:equatable/equatable.dart';

class Category with EquatableMixin {
  const Category({
    required this.name,
    required this.id,
  });

  final String id;
  final String name;

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}
