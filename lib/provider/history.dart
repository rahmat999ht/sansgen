import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/history/request_post.dart';
import 'package:sansgen/model/history/response_get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../services/prefs.dart';

class HistoryProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<Response> fetchHistoryByIdBook(String idBook) async {
    try {
      final String urlHistoryByIdBook =
          '${KeysApi.history}${KeysApi.books}/$idBook';
      final response = get(urlHistoryByIdBook);
      return response;
    } catch (error) {
      log(error.toString(), name: "catch error History");
      rethrow;
    }
  }

  Future<Response> fetchHistory() async {
    const String urlHistory = KeysApi.history;
    log(urlHistory, name: "data url History");
    return get(urlHistory);
  }

  Future postHistory({
    required String uuidBook,
    required String idChapter,
    required ModelRequestPostHistory request,
  }) async {
    try {
      final String urlPostHistory =
          '${KeysApi.history}${KeysApi.books}/$uuidBook${KeysApi.chapters}/$idChapter';
      log(urlPostHistory, name: "data url Post History");
      final response = await post(
        urlPostHistory,
        request.toJson(),
      );
      log(response.statusCode.toString(),
          name: 'response status code Post History');
      if (response.status.hasError) {
        log(response.bodyString.toString(), name: 'response History error');
        return Future.error(response);
      } else {
        log(response.bodyString!, name: 'data response History');
        return modelResponseGetHistoryFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error History");
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
