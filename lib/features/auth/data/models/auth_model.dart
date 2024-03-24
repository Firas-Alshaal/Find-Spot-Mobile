import 'package:lost_find_tracker/features/auth/data/models/user_model.dart';

class AuthUser {
  AuthUser({
    required this.accessToken,
    required this.user,
  });

  late final String accessToken;
  late final UserModel user;

  AuthUser.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    user = UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['user'] = user.toJson();
    return data;
  }
}
