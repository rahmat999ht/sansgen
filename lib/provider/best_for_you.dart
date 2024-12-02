import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../services/prefs.dart';

class BestForYouProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<Response> fetchBooksBestForYou() async {
    const String urlBestForYou = KeysApi.bestForYou;
    return get(urlBestForYou);
  }

  @override
  void onInit() {
    _prefService.prefInit();
    httpClient.addRequestModifier<dynamic>((request) {
      final token = _prefService.getUserToken;
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });
    httpClient.baseUrl = baseURL + KeysApi.api;
    super.onInit();
  }
}
