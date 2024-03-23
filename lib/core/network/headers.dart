import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection_container.dart' as di;

class Api {
  Map<String, String> setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<Map<String, String>> getHeaders() async => {
        'content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await getToken()}',
      };

  Future<Map<String, String>> getHeadersMap() async => {
        'content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await getToken()}',
        'Accept-Language': 'en',
        'Api-Key': 'ADD_YOUR_API_KEY'
      };


  Future getToken() async {
    var localStorage = di.sl<SharedPreferences>();
    return localStorage.getString(Constants.TOKEN);
  }
}
