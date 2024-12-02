import 'package:get/get.dart';

import '../../../../../provider/auth.dart';
import '../../../../../services/prefs.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrefService>(
      () => PrefService(),
    );
    Get.lazyPut<AuthProvider>(
      () => AuthProvider(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(
        authProvider: Get.find(),
        prefService: Get.find(),
      ),
    );
  }
}
