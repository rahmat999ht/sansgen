import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:sansgen/model/book/books.dart';
import 'package:sansgen/utils/ext_context.dart';

import 'image_book.dart';

GestureDetector cardBook({
  required DataBook book,
  required BuildContext context,
  required Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        // color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageBook(
            image: book.image!,
            height: 160,
            width: 130,
            radius: 8,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(book.title, style: context.titleSmallBold),
                // const Gap(4),
                Text('By: ${book.writer}', style: context.labelSmall),
                const Gap(4),
                Container(
                  height: 20,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: context.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Text(
                    book.category ?? '-',
                    style: context.labelSmall.copyWith(
                      color: context.colorScheme.primary,
                      height: 1,
                    ),
                  ),
                ),
                const Gap(4),
                Text(
                  '${book.manyChapters} bab',
                  style: context.labelSmall.copyWith(
                    color: context.colorScheme.secondary,
                  ),
                ),
                // const Gap(12),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Text('Sinopsis :', style: context.labelSmallBold),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Html(
                        data: book.synopsis,
                        style: {
                          "div": Style(
                            padding: HtmlPaddings.all(0),
                            fontSize: FontSize.small,
                            fontStyle: FontStyle.normal,
                            lineHeight: const LineHeight(1.2),
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
