import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/app/modules/audio_bok/controllers/audio_book_controller.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/image_book.dart';

import '../../../../state/empty.dart';
import '../../../../state/error.dart';
import '../../../../state/loading.dart';

class AudioBookView extends GetView<AudioBookController> {
  const AudioBookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Scaffold(
          appBar: appBar(
            ctx: context,
            data: state!,
          ),
          body: SafeArea(
            child: Column(
              children: [
                content(ctx: context, data: state),
              ],
            ),
          )),
      onLoading: const LoadingState(),
      onError: (error) => ErrorState(error: error.toString()),
      onEmpty: const EmptyState(),
    );
  }

  Widget content({
    required BuildContext ctx,
    required ModelDataAudioPage data,
  }) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Obx(
              () => Container(
                height: Get.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ctx.colorScheme.primaryContainer,
                        ctx.colorScheme.primaryContainer.withOpacity(0.2),
                      ]),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: controller.isViewListing.isTrue
                    ? listingAudio(ctx: ctx, data: data)
                    : imageAudio(ctx: ctx, data: data),
              ),
            ),
            Positioned(
              bottom: -25,
              left: 100,
              right: 100,
              child: ElevatedButton(
                onPressed: controller.stateViewListing,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(200, 50),
                ),
                child: Obx(
                  () => Text(
                    controller.isViewListing.isTrue
                        ? 'Tutup Teks'
                        : 'Lihat Teks',
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: StreamBuilder(
            stream: controller.audioPlayer.positionalDataStream,
            builder: (context, snapshot) {
              final positionalData = snapshot.data;
              return ProgressBar(
                barHeight: 4,
                baseBarColor: context.colorScheme.secondary,
                bufferedBarColor: context.colorScheme.secondary,
                progressBarColor: context.colorScheme.onSecondaryContainer,
                thumbColor: context.colorScheme.onSecondaryContainer,
                timeLabelPadding: 12,
                timeLabelTextStyle: TextStyle(
                  color: context.colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
                progress: positionalData?.position ?? Duration.zero,
                buffered: positionalData?.bufferedPosition ?? Duration.zero,
                total: positionalData?.duration ?? Duration.zero,
                onSeek: controller.audioPlayer.jumToDuration,
              );
            },
          ),
        ),
        Gap(Get.height * 0.02),
        controller.isViewAudio.isTrue
            ? Row(
                children: [
                  const Spacer(flex: 3),
                  GestureDetector(
                    onTap: controller.previousChapter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(KeysAssetsIcons.skipPrevious),
                    ),
                  ),
                  const Gap(16),
                  GestureDetector(
                    onTap: controller.onAudio,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => Icon(
                            controller.stateAudio.isTrue
                                ? Icons.pause
                                : Icons.play_arrow_rounded,
                            color: ctx.colorScheme.primary,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  GestureDetector(
                    onTap: controller.nextChapter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(KeysAssetsIcons.skipNext),
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  Widget listingAudio({
    required BuildContext ctx,
    required ModelDataAudioPage data,
  }) {
    return controller.obx(
      (state) => SingleChildScrollView(
        controller: controller.scrollController,
        physics: controller.isAutoScrolling.value
            ? const NeverScrollableScrollPhysics()
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Html(
                data: state!.dataChapter.content,
                style: {
                  "div": Style(
                    fontSize: FontSize.large,
                    fontStyle: FontStyle.normal,
                  )
                },
              ),
            ],
          ),
        ),
      ),
      onLoading: const LoadingState(),
      onError: (error) => ErrorState(error: error.toString()),
      onEmpty: const EmptyState(),
    );
  }

  Widget imageAudio({
    required BuildContext ctx,
    required ModelDataAudioPage data,
  }) {
    return Column(
      children: [
        const Gap(12),
        imageBook(
          image: data.dataBook.image,
          height: Get.height * 0.37,
          width: 200,
          radius: 8,
        ),
        // Container(
        //   height: Get.height * 0.37,
        //   width: 200,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: NetworkImage(data.dataBook.image!),
        //       fit: BoxFit.cover,
        //     ),
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        // ),
        const Gap(20),
        judul(
          judul: data.dataChapter.title,
          author: data.dataBook.publisher,
          ctx: ctx,
        ),
      ],
    );
  }

  AppBar appBar({
    required BuildContext ctx,
    required ModelDataAudioPage data,
  }) {
    return AppBar(
      backgroundColor: ctx.colorScheme.primaryContainer,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Card(
                color: ctx.colorScheme.primary.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                  ),
                ),
              ),
            ),
            Text(
              data.dataBook.title,
              style: ctx.titleMedium,
            ),
            Text(
              'Bab ${data.dataChapter.number}',
              style: ctx.titleMedium,
            )
          ],
        ),
      ),
    );
  }

  Column judul(
      {required String judul,
      required String author,
      required BuildContext ctx}) {
    return Column(
      children: [
        Text(judul, style: ctx.titleLargeBold),
        const Gap(20),
        Text('di Publis Oleh', style: ctx.titleMediumBold),
        Text(author)
      ],
    );
  }
}
