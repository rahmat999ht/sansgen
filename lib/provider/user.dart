import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sansgen/model/user/response_get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/user/logout.dart';
import '../model/user/request_patch_user.dart';
import '../services/prefs.dart';

class UserProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<Response> fetchUserId() async {
    const String urlUserId = KeysApi.users + KeysApi.current;
    log(urlUserId, name: "data url User Id");
    return get(urlUserId);
  }

  Future<Response> patchOnBoarding(ModelRequestPatchUser request) async {
    return post(KeysApi.users + KeysApi.current, request.toOnBoarding());
  }

  Future patchInfoPribadi(
      ModelRequestPatchUser request, XFile? imagePath) async {
    try {
      const String patchUserCurrent = KeysApi.users + KeysApi.current;
      log(baseURL, name: "data baseURL");
      log(patchUserCurrent, name: "data url patchUserCurrent");

      final formData = FormData({});
      // Tambahkan data teks lainnya
      request.toInfoPribadi().forEach((key, value) {
        formData.fields.add(MapEntry(key, value?.toString() ?? ''));
      });

      // Tambahkan gambar jika ada
      if (imagePath != null) {
        formData.files.add(MapEntry(
          'image',
          MultipartFile(File(imagePath.path), filename: imagePath.name),
        ));
      }

      // Gunakan 'patch' bukan 'post' untuk permintaan PATCH
      final response = await post(
        patchUserCurrent,
        formData,
      );

      if (response.status.hasError) {
        if (response.statusCode == 401) {
          throw Exception('Unauthorized');
        } else if (response.statusCode == 500) {
          throw Exception('Internal Server Error');
        } else {
          throw Exception('Failed to update user: ${response.statusCode}');
        }
      } else {
        log(response.bodyString.toString(),
            name: 'data bodyString patchUserCurrent');
        return modelResponseUserFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error patchUserCurrent");
      rethrow;
    }
  }

  Future patchReference(ModelRequestPatchUser request) async {
    try {
      const String patchUserCurrent = KeysApi.users + KeysApi.current;
      log(baseURL, name: "data baseURL");
      log(patchUserCurrent, name: "data url patchUserCurrent");
      final response = await post(
        patchUserCurrent,
        request.toReference(),
      );
      if (response.status.hasError) {
        log(response.toString(), name: 'data error patchUserCurrent');
        if (response.statusCode == 401) {
          // Handle unauthorized error (misalnya, logout pengguna)
          throw Exception('Unauthorized');
        } else if (response.statusCode == 500) {
          // Handle internal server error
          throw Exception('Internal Server Error');
        } else {
          // Handle other error codes
          throw Exception('Failed to update user: ${response.statusCode}');
        }
      } else {
        return modelResponseUserFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error patchUserCurrent");
      rethrow;
    }
  }

  Future logOut() async {
    try {
      final response = await post(
        KeysApi.users + KeysApi.logout,
        {},
      );
      if (response.status.hasError) {
        log(response.body.toString(), name: 'login error');
        throw Exception('Failed to login');
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        return modelResponsePostLogOutFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "auth regis error");
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
