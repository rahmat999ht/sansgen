import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../state/error.dart';
import '../../../../state/loading.dart';
import '../../../../widgets/book_empty.dart';
import '../../../../widgets/card_book.dart';
import '../controllers/riwayat_controller.dart';

class BelumSelesaiDiBaca extends GetView<RiwayatController> {
  const BelumSelesaiDiBaca({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => (state!.listBookNotFinish.isEmpty)
          ? Expanded(
            child: Column(
              children: [
                const Gap(140),
                Center(child: bookEmpty('Anda belum memulai mencaba buku apapun')),
              ],
            ),
          )
          : ListView.builder(
              itemCount: state.listBookNotFinish.length,
              itemBuilder: (context, index) {
                final book = state.listBookNotFinish[index];
                return cardBook(
                  book: book,
                  context: context,
                  onTap: () {
                    controller.toDetails(book);
                  },
                );
              },
            ),
      onLoading: const LoadingState(),
      onError: (error) => ErrorState(error: error.toString()),
      onEmpty: bookEmpty('Anda belum memulai mencaba buku apapun'),
    );
  }
}
