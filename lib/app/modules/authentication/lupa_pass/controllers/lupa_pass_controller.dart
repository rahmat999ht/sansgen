import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/lupa_pass/request_lupa_pass.dart';

import '../../../../../provider/auth.dart';

class LupaPassController extends GetxController {
  final AuthProvider authProvider;
  LupaPassController({required this.authProvider});
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void backToLogin() {
    Get.back();
  }

  bool nullValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return true;
    }
    return false;
  }

  String? validateEmail(String? email) {
    if (nullValidation(email)) {
      return 'Email harap di isi';
    }
    // Regex untuk validasi email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email!)) {
      return 'Format email tidak valid';
    }
    return '';
  }

  Future kirimEmail() async {
    try {
      if (validateEmail(emailController.text) != '') {
        return Get.snackbar(
          "Ups!",
          "Sepertinya ada beberapa field yang terlewat. Yuk, lengkapi dulu!",
        );
      }
      EasyLoading.show(status: "loading");
      final request = ModelRequestPostLupaPass(email: emailController.text);
      await authProvider.authLupaPass(request).then((v) async {
        EasyLoading.dismiss();
        emailController.clear();
        Get.defaultDialog(
          title: "info",
          middleText:
              "Kami telah mengirimkan tautan pengaturan ulang kata sandi Anda melalui email!",
          onConfirm: Get.back,
          textConfirm: "ok",
        );
        log(v.toJson().toString());
        return;
      }).onError((e, st) {
        EasyLoading.dismiss();
        Get.defaultDialog(
          title: "info",
          middleText: "email yang anda input tidak terdaftar sebagai pengguna",
          onConfirm: Get.back,
          textConfirm: "ok",
        );
        return;
      });
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text('Error: $e'),
      );
    }
  }
}
