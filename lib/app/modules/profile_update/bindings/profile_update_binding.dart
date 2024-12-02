import 'package:get/get.dart';

import '../controllers/image_profil_controller.dart';
import '../controllers/profile_update_controller.dart';

class ProfileUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileUpdateController>(
      () => ProfileUpdateController(userProvider: Get.find()),
    );
    Get.lazyPut<ImageUpdateController>(
      () => ImageUpdateController(),
    );
  }
}
