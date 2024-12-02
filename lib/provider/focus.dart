import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/focus/response_get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/focus/request_put.dart';
import '../model/focus/response_post.dart';
import '../services/prefs.dart';

class FocusProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<ModelResponseGetFocus> fetchFocusByUser() async {
    try {
      const String urlFocusId = KeysApi.focus;
      log(urlFocusId, name: "data url Focus Id");
      final response = await get(urlFocusId);
      if (response.status.hasError) {
        log(response.bodyString.toString(), name: 'response urlFocusId error');
        return Future.error(response);
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        // log(response.bodyString!, name: 'data response');
        return modelResponseGetFocusFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch user error");
      rethrow;
    }
  }

  Future putFocusCurrent(ModelRequestPutFocus request) async {
    try {
      const String putFocusCurrent = KeysApi.focus;
      log(putFocusCurrent, name: "data url putFocusCurrent");
      final response = await post(
        putFocusCurrent,
        request.toJson(),
      );
      log(response.statusCode.toString(), name: "statusCode putFocusCurrent");

      if (response.status.hasError) {
        log(response.toString(), name: 'data error putFocusCurrent');
        return Future.error(response);
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        // log(response.bodyString!, name: 'data response');
        return modelResponsePostFocusFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error putFocusCurrent");
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
