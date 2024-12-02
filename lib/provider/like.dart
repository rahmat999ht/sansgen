import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/like/response_like.dart';
import '../services/prefs.dart';

class LikeProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<ModelResponseGetLike> fetchLikeByBookId(
      {required String uuidBook}) async {
    try {
      final String urlLikeByBookId =
          '${KeysApi.books}/$uuidBook${KeysApi.likes}';
      log(urlLikeByBookId, name: "data url LikeByBookId");
      final response = await get(urlLikeByBookId);
      if (response.status.hasError) {
        log(response.toString(), name: 'response error');
        return Future.error(response);
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        // log(response.bodyString!, name: 'data response');
        return modelResponseGetLikeFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error");
      rethrow;
    }
  }

  Future postLikeBook({required String uuidBook}) async {
    try {
      final String urlPostLikeBook =
          '${KeysApi.books}/$uuidBook${KeysApi.likes}';
      log(urlPostLikeBook, name: "data url Product");
      final response = await post(
        urlPostLikeBook,
        {},
      );
      return response;
    } catch (error) {
      log(error.toString(), name: "catch error");
      rethrow;
    }
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
