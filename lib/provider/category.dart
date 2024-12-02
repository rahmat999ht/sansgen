
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';

class CategoryProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  Future<Response> fetchCategory() async {
    const String urlCategory = KeysApi.category;
    return get(urlCategory);
  }

  @override
  void onInit() {
    httpClient.baseUrl = baseURL + KeysApi.api;
    super.onInit();
  }
}
