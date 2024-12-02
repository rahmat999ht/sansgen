import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:sansgen/model/user/request_patch_user.dart';
import 'package:sansgen/model/user/user.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../model/category/response_get.dart';
import '../../../../model/error.dart';
import '../../../../model/on_boarding/referency.dart';
import '../../../../provider/category.dart';
import '../../../../provider/user.dart';
import '../../../routes/app_pages.dart';

class ProfilePreferenciController extends GetxController
    with StateMixin<ModelUpdatePreferencyPage> {
  final UserProvider userProvider;
  final CategoryProvider categoryProvider;

  ProfilePreferenciController({
    required this.categoryProvider,
    required this.userProvider,
  });

  ModelUser? dataUser;

  var listPreferences = <ModelPreferenci>[];

  @override
  void onInit() async {
    getArgument();
    super.onInit();
  }

  Future<bool> onWillPop(BuildContext context) async {
    return await Get.defaultDialog(
          title: 'Peringatan!',
          middleText: "Yakin mau batalin update preferensi?",
          confirm: TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              'Ya',
              style: context.titleMedium
                  .copyWith(color: context.colorScheme.surface),
            ),
          ),
          cancel: TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              'Batal',
              style: context.titleMedium
                  .copyWith(color: context.colorScheme.surface),
            ),
          ),
        ) ??
        false;
  }

  Future getArgument() async {
    try {
      final resultCategory = await categoryProvider.fetchCategory();

      if (Get.arguments != null && resultCategory.isOk) {
        final dataCategories =
            modelResponseGetCategoryFromJson(resultCategory.bodyString!);

        listPreferences = dataCategories.categories
            .map((e) => ModelPreferenci(
                  id: e.id,
                  title: e.name,
                  isSelected: false.obs,
                ))
            .toList();
        dataUser = Get.arguments;
        for (var pref in listPreferences) {
          if (dataUser!.categories
              .map((e) => e.toLowerCase())
              .contains(pref.title.toLowerCase())) {
            pref.isSelected.value = true;
          }
        }
        final dataPage = ModelUpdatePreferencyPage(
          user: dataUser!,
          categories: listPreferences,
        );
        change(dataPage, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future simpan() async {
    try {
      final categorySelesai = listPreferences
          .where((e) => e.isSelected.value == true)
          .map((v) => v.id)
          .toList();
      if (categorySelesai.length < 3) {
        Get.snackbar(
          'Info',
          'Silakan pilih setidaknya 3 kategori buku',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
        return;
      } else {
        EasyLoading.show(status: "Loading");

        final request = ModelRequestPatchUser(idCategory: categorySelesai);

        return userProvider.patchReference(request).then((v) async {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Update Data berhasil');
          log(v.toJson().toString());
          Get.offAllNamed(Routes.DASHBOARD, arguments: 3);
          return;
        }).onError((e, st) {
          EasyLoading.dismiss();
          final errors = Errors(message: ['$e', '$st']);
          final dataError = ModelResponseError(errors: errors);
          log(dataError.toJson().toString());
          EasyLoading.showError('Update Data Gagal');
          return;
        });
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text('Error: $e'),
      );
    }
  }
}

class ModelUpdatePreferencyPage {
  final ModelUser user;
  final List<ModelPreferenci> categories;

  ModelUpdatePreferencyPage({required this.user, required this.categories});

  ModelUpdatePreferencyPage copyWith({
    ModelUser? user,
    List<ModelPreferenci>? categories,
  }) {
    return ModelUpdatePreferencyPage(
      user: user ?? this.user,
      categories: categories ?? this.categories,
    );
  }
}
