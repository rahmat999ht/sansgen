import 'package:get/get.dart';

import '../../../../../provider/auth.dart';
import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(
      () => AuthProvider(),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        authProvider: Get.find(),

      ),
    );
  }
}
