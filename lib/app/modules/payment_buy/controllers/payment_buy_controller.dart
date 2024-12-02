import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/user/user.dart';
import 'package:sansgen/provider/payment.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PaymentBuyController extends GetxController with StateMixin<ModelUser> {
  final PaymentProvider paymentProvider;

  PaymentBuyController({required this.paymentProvider});

  @override
  void onInit() {
    fetchDataProfil();
    super.onInit();
  }

  Future<bool> onWillPop(BuildContext context) async {
    return await Get.defaultDialog(
          title: 'Peringatan!',
          middleText: "Yakin mau batalin pembayaran payment",
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

  Future launchURL(String url) async => await canLaunchUrlString(url)
      ? await launchUrlString(url)
      : log('Could not launch $url');

  Future postPayment() async {
    EasyLoading.show(status: 'Loading');
    paymentProvider.postRedirect().then((v) async {
      if (v.checkoutLink == null || v.checkoutLink == "") {
        EasyLoading.dismiss();
        Get.defaultDialog(
          title: "Info",
          middleText:
              "Akun anda sudah premium \n ${v.activeUntil ?? "Aktif hingga"}",
          onConfirm: Get.back,
          textConfirm: "OK",
          buttonColor: Colors.greenAccent,
        );
      } else {
        EasyLoading.dismiss();
        launchURL(v.checkoutLink!);
      }
    }).onError((e, st) {
      EasyLoading.dismiss();
      log(e.toString());
      EasyLoading.showError('Pembayaran Gagal');
      return;
    });
  }

  void fetchDataProfil() {
    try {
      if (Get.arguments == null) {
        change(null, status: RxStatus.empty());
      } else {
        change(Get.arguments as ModelUser, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
