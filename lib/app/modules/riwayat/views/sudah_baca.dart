import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../state/error.dart';
import '../../../../state/loading.dart';
import '../../../../widgets/book_empty.dart';
import '../../../../widgets/card_book.dart';
import '../controllers/riwayat_controller.dart';

class SudahSelesaiDiBaca extends GetView<RiwayatController> {
  const SudahSelesaiDiBaca({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => (state!.listBookFinish.isEmpty)
          ? Expanded(
              child: Column(
                children: [
                  const Gap(140),
                  Center(
                      child: bookEmpty('Anda belum menyelesaikan buku apapun')),
                ],
              ),
            )
          : ListView.builder(
              itemCount: state.listBookFinish.length,
              itemBuilder: (context, index) {
                final book = state.listBookFinish[index];
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
      onEmpty: bookEmpty('Anda belum menyelesaikan buku apapun'),
    );
  }
}
