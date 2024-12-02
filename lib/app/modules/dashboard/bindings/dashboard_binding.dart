import 'package:get/get.dart';
import 'package:sansgen/app/modules/home/controllers/home_controller.dart';
import 'package:sansgen/app/modules/kategori/controllers/kategori_controller.dart';
import 'package:sansgen/app/modules/profil/controllers/profil_controller.dart';
import 'package:sansgen/app/modules/riwayat/controllers/riwayat_controller.dart';
import 'package:sansgen/provider/book.dart';
import 'package:sansgen/provider/category.dart';
import 'package:sansgen/provider/focus.dart';
import 'package:sansgen/provider/history.dart';
import 'package:sansgen/provider/user.dart';

import '../../../../provider/best_for_you.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookProvider>(
      () => BookProvider(),
    );
    Get.put<HistoryProvider>(
      HistoryProvider(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.put<FocusProvider>(
      FocusProvider(),
    );
    Get.lazyPut<BestForYouProvider>(
      () => BestForYouProvider(),
    );
    Get.lazyPut<CategoryProvider>(
      () => CategoryProvider(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        bookProvider: Get.find(),
        userProvider: Get.find(),
        focusProvider: Get.find(),
        bestForYouProvider: Get.find(),
      ),
    );
    Get.lazyPut<KategoriController>(
      () => KategoriController(
        bookProvider: Get.find(),
        categoryProvider: Get.find(),
      ),
    );
    Get.lazyPut<RiwayatController>(
      () => RiwayatController(
        historyProvider: Get.find(),
        bookProvider: Get.find(),
      ),
    );
    Get.lazyPut<ProfilController>(
      () => ProfilController(
        userProvider: Get.find(),
      ),
    );
  }
}
