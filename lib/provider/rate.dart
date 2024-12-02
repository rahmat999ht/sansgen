import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../model/comment/response_post.dart';
import '../keys/api.dart';
import '../keys/env.dart';
import '../model/error.dart';
import '../model/ratings/request_post.dart';
import '../model/ratings/response_get.dart';
import '../services/prefs.dart';

class RatingProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<ModelResponseGetRate> fetchRatingByBookId(
      {required String uuidBook}) async {
    try {
      final String urlRatingByBookId =
          '${KeysApi.books}/$uuidBook${KeysApi.rate}';
      log(urlRatingByBookId, name: "data url RatingByBookId");
      final response = await get(urlRatingByBookId);
      if (response.status.hasError) {
        log(response.toString(), name: 'response error');
        return Future.error(response);
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        // log(response.bodyString!, name: 'data response');
        return modelResponseGetRateFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error");
      rethrow;
    }
  }

  Future postRatingBook({
    required String uuidBook,
    required ModelRequestPostRate request,
  }) async {
    try {
      final String urlPostRatingBook =
          '${KeysApi.books}/$uuidBook${KeysApi.rate}';
      log(urlPostRatingBook, name: "data url post rate");
      final response = await post(
        urlPostRatingBook,
        request.toJson(),
      );
      if (response.status.hasError) {
        log(response.bodyString.toString(), name: 'data error');
        // return Future.error(response.bodyString.toString());
        return modelResponseErrorFromJson(response.bodyString!);
      } else {
        log(response.bodyString!, name: 'data response');
        return modelResponsePostCommentFromJson(response.bodyString!);
      }
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
