import 'package:equatable/equatable.dart';

class MapItem with EquatableMixin {
   MapItem({
    this.country,
    this.city,
    this.formattedAddress,
    this.lat,
    this.long,
  });

  final String? country;
  final String? city;
  final String? formattedAddress;
   double? lat;
   double? long;

  @override
  List<Object?> get props => [
        country,
        city,
        formattedAddress,
        lat,
        long,
      ];
}
