import 'package:get/get.dart';
import 'package:sansgen/provider/payment.dart';

import '../controllers/payment_buy_controller.dart';

class PaymentBuyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentProvider>(
      () => PaymentProvider(),
    );
    Get.lazyPut<PaymentBuyController>(
      () => PaymentBuyController(paymentProvider: Get.find()),
    );
  }
}
