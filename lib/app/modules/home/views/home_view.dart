import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:hidable/hidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sansgen/model/book/books.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/utils/ext_string.dart';
import 'package:sansgen/widgets/avatar_widget.dart';
import 'package:sansgen/widgets/book_empty.dart';

import '../../../../state/empty.dart';
import '../../../../state/error.dart';
import '../../../../state/loading.dart';
import '../../../../widgets/footer.dart';
import '../../../../widgets/header.dart';
import '../../../../widgets/image_book.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Hidable(
        controller: controller.scrollController,
        enableOpacityAnimation: true, // optional, defaults to `true`.
        preferredWidgetSize: Size.fromHeight(
          controller.isAppBarVisible.value ? 140 : 0,
        ),
        child: Obx(
          () => appBarCustom(
            context: context,
            name: controller.appBarData.value.name,
            image: controller.appBarData.value.image,
            reading: controller.appBarData.value.reading,
            books: controller.appBarData.value.books,
            focus: controller.appBarData.value.focus,
          ),
        ),
      ),
      body: Material(
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullUp: true,
          onRefresh: controller.onRefresh,
          header: const Header(),
          footer: const Footer(),
          onLoading: controller.onLoading,
          child: controller.obx(
            (state) => ListView(
              controller: controller.scrollController,
              shrinkWrap: true,
              children: [
                const Gap(40),
                SizedBox(
                  height: 228,
                  width: double.infinity,
                  child: componentCard(
                    title: 'Pilihan terbaik untukmu',
                    emptyInfo: '',
                    context: context,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state!.bestForYou.length,
                    itemBuilder: (context, index) {
                      final book = state.bestForYou[index];
                      return cardTerbaikUntukmu(
                        book: book,
                        onTap: () {
                          controller.toDetails(book);
                        },
                      );
                    },
                  ),
                ),
                const Gap(20),
                componentCard(
                  title: 'Populer',
                  emptyInfo: '',
                  context: context,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.populer.length,
                  itemBuilder: (context, index) {
                    final book = state.populer[index];
                    return cardPopuler(
                      book: book,
                      context: context,
                      onTap: () {
                        controller.toDetails(book);
                      },
                    );
                  },
                ),
                // const Gap(80),
              ],
            ),
            onLoading: const LoadingState(),
            onError: (error) => ErrorState(error: error.toString()),
            onEmpty: const EmptyState(),
          ),
        ),
      ),
    );
  }

  Widget cardPopuler({
    required DataBook book,
    required BuildContext context,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 87,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          // color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            imageBook(
              image: book.image!,
              height: 87,
              width: 76,
              radius: 8,
            ),
            const Gap(12),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.6,
                  child: Text(
                    book.title,
                    softWrap: true,
                    style: context.titleSmallBold,
                  ),
                ),
                Text(
                  book.category ?? '-',
                  style: context.labelSmall.copyWith(
                    color: context.colorScheme.secondary,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    Text(
                      book.averageRate.toString(),
                      style: context.labelSmall.copyWith(
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector cardTerbaikUntukmu({
    required DataBook book,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        child: imageBook(
          image: book.image!,
          height: 190,
          width: 149,
          radius: 8,
        ),
      ),
    );
  }

  Widget componentCard({
    required String title,
    required BuildContext context,
    required Axis scrollDirection,
    required ScrollPhysics physics,
    required int itemCount,
    required Widget? Function(BuildContext, int) itemBuilder,
    required String emptyInfo,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: context.titleMedium),
              // Text(
              //   'Lainnya',
              //   style: context.labelLarge.copyWith(
              //     decoration: TextDecoration.underline,
              //     decorationThickness: 2,
              //     decorationStyle: TextDecorationStyle.solid,
              //     decorationColor: context.colorScheme.secondary,
              //   ),
              // ),
            ],
          ),
        ),
        if (scrollDirection == Axis.horizontal) const Gap(10),
        if (itemCount == 0)
          bookEmpty(emptyInfo, height: 170)
        else
          SizedBox(
            // Ganti Expanded dengan SizedBox
            height: scrollDirection == Axis.horizontal ? 190 : null,
            width: Get.width,
            // Tetapkan tinggi jika horizontal
            child: ListView.builder(
              itemCount: itemCount,
              shrinkWrap: true,
              scrollDirection: scrollDirection,
              physics: physics,
              itemBuilder: itemBuilder,
            ),
          ),
      ],
    );
  }

  AppBar appBarCustom({
    required BuildContext context,
    required String name,
    required String image,
    required String reading,
    required String books,
    required String focus,
  }) {
    return AppBar(
      backgroundColor: context.colorScheme.primary,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.onSecondaryContainer,
              context.colorScheme.primaryContainer,
            ],
            stops: const [0.0, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Halo!',
            style: context.titleMedium
                .copyWith(color: context.colorScheme.primary),
          ),
          Text(
            name,
            style: context.titleMediumBold
                .copyWith(color: context.colorScheme.primary),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () => controller.dashController.setCurrentIndex(3),
          child: SizedBox(
            width: 40,
            height: 40,
            child: AvatarWidget(
              image: image,
            ),
          ),
        ),
        const Gap(20),
      ],
      bottom: bottomAppBar(
        context: context,
        reading: reading,
        books: books,
        focus: focus,
      ),
    );
  }

  PreferredSize bottomAppBar({
    required BuildContext context,
    required String reading,
    required String books,
    required String focus,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: Expanded(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -30,
              left: 0,
              right: 0,
              child: Container(
                width: 100,
                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      color: context.colorScheme.secondary,
                      blurRadius: 9,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dataHeader(
                      context,
                      title: reading.formatDuration(),
                      subTitle: 'Reading',
                    ),
                    dataHeader(
                      context,
                      title: books.formatDuration(),
                      subTitle: 'Books',
                    ),
                    dataHeader(
                      context,
                      title: focus.formatDuration(),
                      subTitle: 'Focus',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column dataHeader(
    BuildContext context, {
    required String title,
    required String subTitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: context.titleMediumBold),
        Text(subTitle, style: context.labelLarge),
      ],
    );
  }
}
