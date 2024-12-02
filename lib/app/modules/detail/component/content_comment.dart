import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/avatar_widget.dart';
import 'package:sansgen/widgets/book_empty.dart';

import '../../../../model/book/book.dart';
import 'input_comment.dart';

Container contentBottomSheetComment({
  required BuildContext context,
  required RxList<Comment> listComment,
  required ScrollController scrollController,
  required TextEditingController controller,
  required void Function() onTapSend,
  // required bool isEmpty,
}) {
  listComment.map(
    (e) => log(e.comment.toString()),
  );
  return Container(
    width: double.infinity,
    height: Get.height * 0.8,
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
    ),
    decoration: BoxDecoration(
      color: context.colorScheme.primary,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Column(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "${listComment.length} Komentar",
          style: context.titleMedium,
        ),
        const Divider(),
        Expanded(
          child: listComment.isEmpty
              ? Center(child: bookEmpty('Komentar masih kosong'))
              : SingleChildScrollView(
                  controller: scrollController,
                  // reverse: true,
                  child: Obx(
                    () => Column(
                      children: listComment.reversed
                          .map(
                            (e) => ListTile(
                              leading: const AvatarWidget(
                                image: '',
                                height: 40,
                                width: 40,
                                heightPlus: 0,
                              ),
                              title: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: e.user.name,
                                        style: context.titleMediumBold),
                                    TextSpan(
                                        text: '  ${e.comment}',
                                        style: context.labelLarge),
                                  ],
                                ),
                              ),
                              subtitle: Text(e.timeElapsed.toString()),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
        ),
        // const Spacer(),
        inputComment(
          hint: 'Tulis komentar anda',
          context: context,
          controller: controller,
          onTapSend: onTapSend,
        ),
      ],
    ),
  );
}
