import 'package:get/get.dart';

import '../../../../../provider/auth.dart';
import '../controllers/lupa_pass_controller.dart';

class LupaPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(
      () => AuthProvider(),
    );
    Get.lazyPut<LupaPassController>(
      () => LupaPassController(
        authProvider: Get.find(),
      ),
    );
  }
}
