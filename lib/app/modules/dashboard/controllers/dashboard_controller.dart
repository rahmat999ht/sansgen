import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/modules/riwayat/views/riwayat_view.dart';

import '../../../../keys/assets_icons.dart';
import '../../home/views/home_view.dart';
import '../../kategori/views/kategori_view.dart';
import '../../profil/views/profil_view.dart';

class DashboardController extends GetxController {
  final Rx<int> _currentIndex = 0.obs;
  int get getCurrentIndex => _currentIndex.value;
  void setCurrentIndex(int value) => _currentIndex.value = value;

  final pages = <ModelPageDashboard>[
    ModelPageDashboard(
      title: '',
      icon: KeysAssetsIcons.home,
      index: 0,
      page: const HomeView(),
    ),
    ModelPageDashboard(
      title: '',
      icon: KeysAssetsIcons.category,
      index: 1,
      page: const KategoriView(),
    ),
    ModelPageDashboard(
      title: '',
      icon: KeysAssetsIcons.riwayat,
      index: 2,
      page: const RiwayatView(),
    ),
    ModelPageDashboard(
      title: '',
      icon: KeysAssetsIcons.user,
      index: 3,
      page: const ProfilView(),
    ),
  ];

  @override
  void onInit() {
    if (Get.arguments == null) {
      setCurrentIndex(0);
    } else {
      setCurrentIndex(Get.arguments);
    }
    super.onInit();
  }

}

class ModelPageDashboard {
  final String title;
  final String icon;
  final int index;
  final Widget page;
  ModelPageDashboard({
    required this.title,
    required this.icon,
    required this.index,
    required this.page,
  });
}
