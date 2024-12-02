import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/login/request_login.dart';
import '../model/lupa_pass/request_lupa_pass.dart';
import '../model/lupa_pass/response_post.dart';
import '../model/register/model_request_register.dart';

class AuthProvider extends GetConnect {
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  Future<Response> authLogin(ModelReqestLogin request) async {
    return post(KeysApi.login, request.toJson());
  }

  Future<Response> authRegister(ModelReqestRegister request) async {
    return post(KeysApi.register, request.toJson());
  }

  Future authLupaPass(ModelRequestPostLupaPass request) async {
    try {
      const String _urlLupaPass = KeysApi.lupaPas;
      log(_urlLupaPass, name: "url LupaPass");
      log(request.toJson().toString(), name: 'request');

      final response = await post(
        _urlLupaPass,
        request.toJson(),
      );
      log(response.toString(), name: "response");

      if (response.status.hasError) {
        log(response.toString(), name: 'LupaPass error');
        return Future.error(response);
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        log(response.bodyString!, name: 'data response LupaPass');
        return modelResponsePostLupaPassFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch LupaPass error");
      rethrow;
    }
  }

  @override
  void onInit() {
    log(baseURL + KeysApi.api, name: 'baseURL');
    httpClient.baseUrl = baseURL + KeysApi.api;
  }
}
