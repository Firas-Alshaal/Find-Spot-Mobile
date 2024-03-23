import 'package:lost_find_tracker/features/goods/domain/entities/map.dart';

class MapModel extends MapItem {
  MapModel({
    String? country,
    String? city,
    String? formattedAddress,
    double? lat,
    double? long,
  }) : super(
            country: country,
            city: city,
            formattedAddress: formattedAddress,
            lat: lat,
            long: long);

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      country: json['country'],
      city: json['city'],
      formattedAddress: json['formatted_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'city': city,
      'formatted_address': formattedAddress,
    };
  }
}
