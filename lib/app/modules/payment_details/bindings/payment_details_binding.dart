import 'package:get/get.dart';

import '../controllers/payment_details_controller.dart';

class PaymentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentDetailsController>(
      () => PaymentDetailsController(),
    );
  }
}
