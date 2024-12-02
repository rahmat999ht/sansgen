import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/payment/post_redirect.dart';
import '../services/prefs.dart';

class PaymentProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<ModelResponsePostRedirectPayment> postRedirect() async {
    try {
      const String urlPostPayment = KeysApi.payment ;
      log(urlPostPayment, name: "data url urlPostPayment");
      final response = await post(urlPostPayment, {});
      log(response.statusCode.toString(), name: 'response statusCode Payment');
      if (response.status.hasError) {
        log(response.bodyString.toString(), name: 'response error Payment');
        if (response.statusCode == 401) {
          // Handle unauthorized error (misalnya, logout pengguna)
          throw Exception('Unauthorized');
        } else if (response.statusCode == 500) {
          // Handle internal server error
          throw Exception('Internal Server Error');
        } else {
          // Handle other error codes
          throw Exception('Failed post payment: ${response.statusCode}');
        }
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        log(response.bodyString!, name: 'data response Payment');
        return modelResponsePostRedirectPaymentFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error Payment");
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
