import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sansgen/app/routes/app_pages.dart';

import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/avatar_widget.dart';

import '../controllers/payment_buy_controller.dart';

class PaymentBuyView extends GetView<PaymentBuyController> {
  const PaymentBuyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return; // Jika sudah di-pop, tidak perlu tindakan lagi
          final onPop = await controller.onWillPop(context);
          if (onPop) {
            Get.offAllNamed(Routes.DASHBOARD, arguments: 3);
          } else {
            return;
          }
        },
        child: Scaffold(
          appBar: appBar(context: context, image: state!.image!),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                txtMain(
                    txt:
                        'Nikmati Pengalaman Membaca Tanpa Batas dengan Aku Premium di Sansgen!',
                    context: context),
                txtDot(
                    txtDot:
                        'Sebagai pengguna premium, Anda memiliki akses tak terbatas ke seluruh koleksi buku di Sansgen. Dari buku sejarah, biografi, hingga buku-buku ilmiah, semuanya tersedia untuk Anda baca kapan saja dan di mana saja. Tidak ada lagi batasan jumlah buku atau bab yang bisa Anda nikmati setiap bulannya!',
                    context: context),
                txtDot(
                    txtDot:
                        'Update dan Rekomendasi Eksklusif, Dapatkan rekomendasi buku terbaru dan terpopuler yang disesuaikan dengan preferensi Anda. Pengguna premium juga menjadi yang pertama mengetahui tentang buku-buku baru yang dirilis.',
                    context: context),
                const SizedBox(
                  height: 10,
                ),
                txtMain(
                    txt:
                        'Jangan lewatkan kesempatan untuk meningkatkan pengalaman membaca Anda! Berlangganan Akun Premium hanya dengan membayar Rp.10.000 di aplikasi baca buku Sansgen sekarang dan rasakan sendiri perbedaannya.',
                    context: context),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: controller.postPayment,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                'Bayar',
                style: context.titleMedium
                    .copyWith(color: context.colorScheme.primary),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar({required BuildContext context, required String image}) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: context.colorScheme.primary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              controller.onWillPop(context).then((e) {
                if (e) {
                  Get.offAllNamed(Routes.DASHBOARD, arguments: 3);
                }
              });
            },
            child: AvatarWidget(
              image: image,
              height: 50.0,
              width: 50,
            ),
          ),
          const Text(
            'Premium',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 50.0,
            width: 50,
          ),
        ],
      ),
    );
  }

  SizedBox txtMain({required String txt, required BuildContext context}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            txt,
            style: context.titleMedium,
          ),
        ],
      ),
    );
  }

  SizedBox txtDot({required String txtDot, required BuildContext context}) {
    return SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              '•',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(txtDot, style: context.titleMedium, softWrap: true))
          ],
        ));
  }
}
