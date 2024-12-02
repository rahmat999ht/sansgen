import 'package:get/get.dart';

import '../controllers/reset_pass_controller.dart';

class ResetPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPassController>(
      () => ResetPassController(),
    );
  }
}
