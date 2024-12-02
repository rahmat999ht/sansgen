import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../state/empty.dart';
import '../../../../state/error.dart';
import '../../../../state/loading.dart';
import '../../../../widgets/card_book.dart';
import '../controllers/list_lainnya_controller.dart';

class ListLainnyaView extends GetView<ListLainnyaController> {
  const ListLainnyaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('  ListLainnya', style: context.titleLarge),
        backgroundColor: context.colorScheme.primary,
      ),
      body: controller.obx(
        (state) => Column(
          children: [
            const Gap(16),
            Expanded(
              child: componentCard(
                title: 'Hasil',
                context: context,
                heightCom: context.height,
                widthCom: double.infinity,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: controller.bookList.length,
                itemBuilder: (context, index) {
                  final book = controller.bookList[index];
                  return cardBook(
                    book: book,
                    context: context,
                    onTap: () {
                      controller.toDetails(book);
                    },
                  );
                },
              ),
            ),
          ],
        ),
        onLoading: const LoadingState(),
        onError: (error) => ErrorState(error: error.toString()),
        onEmpty: const EmptyState(),
      ),
    );
  }

  SizedBox componentCard({
    required String title,
    required BuildContext context,
    required double heightCom,
    required double widthCom,
    required Axis scrollDirection,
    required ScrollPhysics physics,
    required int itemCount,
    required Widget? Function(BuildContext, int) itemBuilder,
  }) {
    return SizedBox(
      height: heightCom,
      width: widthCom,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: context.titleMedium),
                Text(
                  'Lainnya',
                  style: context.labelLarge.copyWith(
                    decoration: TextDecoration.underline,
                    decorationThickness: 2,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: context.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemCount,
              shrinkWrap: true,
              scrollDirection: scrollDirection,
              physics: physics,
              itemBuilder: itemBuilder,
            ),
          ),
        ],
      ),
    );
  }
}
