import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'package:get/get.dart';
import 'package:hidable/hidable.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/image_book.dart';

import '../../../../model/book/book.dart';
import '../../../../services/common.dart';
import '../../../../state/empty.dart';
import '../../../../state/error.dart';
import '../../../../state/loading.dart';
import '../controllers/reading_book_controller.dart';

class ReadingBookView extends GetView<ReadingBookController> {
  const ReadingBookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: controller.scaffoldKey,
        drawer: contentDrawer(context),
        appBar: Hidable(
          controller: controller.scrollController,
          enableOpacityAnimation: true, // optional, defaults to `true`.
          preferredWidgetSize: Size.fromHeight(
            controller.isAppBarVisible.value ? 100 : 0,
          ),
          child: AppBar(
            elevation: 40,
            toolbarHeight: controller.isAppBarVisible.value ? 44 : 0,
            title: const Text('ReadingBookView'),
            backgroundColor: context.colorScheme.primary,
            leadingWidth: 80,
            leading: CircleAvatar(
              backgroundColor: context.colorScheme.secondaryContainer,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
            ),
            // actions: actions(context),
            // centerTitle: true,
          ),
        ),
        body: controller.obx(
          (state) => SingleChildScrollView(
            controller: controller.scrollController,
            physics: controller.isAutoScrolling.value
                ? const NeverScrollableScrollPhysics()
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  dataContent(
                    context,
                    state!.dataChapter.content,
                  ),
                ],
              ),
            ),
          ),
          onLoading: const LoadingState(),
          onError: (error) => ErrorState(error: error.toString()),
          onEmpty: const EmptyState(),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: controller.isViewMusic.isFalse
            ? null
            : FloatingActionButton(
                onPressed: controller.onMusic,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: (controller.stateMusic.isFalse)
                    ? SvgPicture.asset(KeysAssetsIcons.musicOn)
                    : Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: SvgPicture.asset(KeysAssetsIcons.musicOff),
                      ),
              ),
        bottomNavigationBar: Visibility(
          visible: controller.isBottomBarVisible.value,
          child: Hidable(
            controller: controller.scrollController,
            enableOpacityAnimation: true,
            // optional, defaults to `true`.
            child: bottomNavBarReading(
              context: context,
              chapter: controller.currentChapter.value.toString(),
              onTapPrevious: controller.previousChapter,
              onTapNext: controller.nextChapter,
              onTapDrawerChapter: controller.openDrawer,
            ),
          ),
        ),
      ),
    );
  }

  Future tampilkanDialogKonfirmasiKeluar(BuildContext context) async {
    Get.defaultDialog(
      title: 'Apakah Anda yakin?',
      middleText: 'Apakah Anda yakin ingin meninggalkan halaman ini?',
      textCancel: 'Keluar',
      textConfirm: 'Batal',
      cancelTextColor: Colors.black,
      confirmTextColor: Colors.white,
      buttonColor: context.colorScheme.surface,
      onCancel: () {
        Get.back(result: false); // Menutup dialog dan mengembalikan false
      },
      onConfirm: () {
        Get.back(result: true); // Menutup dialog dan mengembalikan true
      },
    );
  }

  Widget dataContent(BuildContext ctx, String dataContentChapter) {
    return Html(data: dataContentChapter, style: {
      "div": Style(
        fontSize: FontSize.large,
        fontStyle: FontStyle.normal,
      )
    });
  }

  SizedBox alertTimer({
    required BuildContext context,
    required int duration,
    required CountDownController controllerTimer,
    required void Function()? onStart,
    required void Function()? onPause,
    required void Function()? onResume,
    required void Function()? onRestart,
  }) {
    return SizedBox(
      height: 360,
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularCountDownTimer(
            duration: duration,
            initialDuration: 0,
            controller: controllerTimer,
            width: 200,
            height: 200,
            ringColor: context.colorScheme.primary,
            ringGradient: null,
            fillColor: context.colorScheme.surface,
            fillGradient: null,
            backgroundColor: context.colorScheme.primaryContainer,
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.S,
            isReverse: false,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: false,
            onStart: () {
              // Here, do whatever you want
              log('Countdown Started');
            },

            // This Callback will execute when the Countdown Ends.
            onComplete: () {
              // Here, do whatever you want
              log('Countdown Ended');
            },

            // This Callback will execute when the Countdown Changes.
            onChange: (String timeStamp) {
              // Here, do whatever you want
              log('Countdown Changed $timeStamp');
            },
            timeFormatterFunction: (defaultFormatterFunction, duration) {
              if (duration.inSeconds == 0) {
                return "0 : 0";
              } else {
                return Function.apply(defaultFormatterFunction, [duration]);
              }
            },
          ),
          const Gap(40),
          StreamBuilder(
            stream: controller.musicPlayer.positionalDataStream,
            builder: (context, snapshot) {
              final positionalData = snapshot.data;
              return progressWidget(positionalData);
            },
          ),
          Card(
            color: context.colorScheme.onPrimary,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onStart,
                  icon: Icon(
                    Icons.pause_circle_outline,
                    color: context.colorScheme.surface,
                  ),
                ),
                IconButton(
                  onPressed: onPause,
                  icon: Icon(
                    Icons.timer,
                    color: context.colorScheme.surface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ProgressBar progressWidget(PositionData? positionalData) {
    return ProgressBar(
      barHeight: 10,
      baseBarColor: Colors.grey,
      bufferedBarColor: Colors.blueGrey,
      progressBarColor: Colors.red,
      thumbColor: Colors.red,
      timeLabelTextStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      progress: positionalData?.position ?? Duration.zero,
      buffered: positionalData?.bufferedPosition ?? Duration.zero,
      total: positionalData?.duration ?? Duration.zero,
      onSeek: controller.musicPlayer.jumToDuration,
    );
  }

  Drawer contentDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: context.colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      width: context.width * 0.55,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          headerDrawer(context),
          Divider(
            color: context.colorScheme.onPrimary,
            height: 1,
          ),
          ...controller.listChapter.map(
            (e) => cardDrawer(e, context),
          ),
        ],
      ),
    );
  }

  Container headerDrawer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Gap(20),
          imageBook(
            image: controller.dataBook!.image,
            height: 200,
            width: 140,
            radius: 8,
          ),
          const Gap(8),
          Text(
            controller.dataBook!.title,
            style: context.titleLargeBold,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Total: ${controller.listChapter.length} Bab',
              style: context.titleSmall,
            ),
          ),
        ],
      ),
    );
  }

  Padding cardDrawer(Chapter e, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: GestureDetector(
        onTap: () => controller.setCurrentChapter(e.number),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.width * 0.4,
              child: Text(
                e.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.titleMedium.copyWith(
                  color: context.colorScheme.onPrimary,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(e.number.toString(), style: context.titleMediumBold),
          ],
        ),
      ),
    );
  }

  Padding bottomNavBarReading({
    required BuildContext context,
    required String chapter,
    void Function()? onTapPrevious,
    void Function()? onTapNext,
    void Function()? onTapDrawerChapter,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTapPrevious,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: const Icon(Icons.arrow_back_ios_rounded),
            ),
          ),
          ElevatedButton(
            onPressed: onTapDrawerChapter,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(context.width * 0.65, 40),
              backgroundColor: context.colorScheme.onSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Obx(() => Text('Bab ${controller.currentChapter}')),
          ),
          GestureDetector(
            onTap: onTapNext,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: const Center(
                  child: Icon(
                Icons.arrow_forward_ios_rounded,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
//
// List<Widget> actions(BuildContext context) {
//   return [
//     IconButton(
//       onPressed: () => controller.openTimer(
//         alertTimer(
//           context: context,
//           duration: controller.initDuration,
//           controllerTimer: controller.controllerTimer,
//           onStart: () {
//             controller.onStartTimer();
//             controller.musicPlayer.play();
//           },
//           onPause: () {
//             controller.onPauseTimer();
//             controller.musicPlayer.pause();
//           },
//           onResume: () {
//             controller.onResumeTimer();
//             controller.musicPlayer.play();
//           },
//           onRestart: () => controller.onRestartTimer(controller.initDuration),
//         ),
//       ),
//       icon: SvgPicture.asset(KeysAssetsIcons.timer),
//     ),
//   ];
// }
// }
