import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/book_empty.dart';

import '../../../../state/empty.dart';
import '../../../../state/error.dart';
import '../../../../state/loading.dart';
import '../../../../widgets/card_book.dart';
import '../../../../widgets/footer.dart';
import '../../../../widgets/header.dart';
import '../controllers/kategori_controller.dart';

class KategoriView extends GetView<KategoriController> {
  const KategoriView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('  Kategori', style: context.titleLarge),
        backgroundColor: context.colorScheme.primary,
        bottom: bottomAppBar(context),
      ),
      body: Material(
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullUp: true,
          onRefresh: controller.onRefresh,
          header: const Header(height: 40),
          footer: const Footer(),
          onLoading: controller.onLoading,
          child: controller.obx(
            (state) => Column(
              children: [
                const Gap(12),
                filterCategory(
                    context: context,
                    categories: controller.filterListKategori),
                const Gap(16),
                Expanded(
                  child: componentCard(
                    title: 'Hasil',
                    context: context,
                    heightCom: context.height,
                    widthCom: double.infinity,
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state!.length,
                    itemBuilder: (context, index) {
                      final book = state[index];
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
        ),
      ),
    );
  }

  SingleChildScrollView filterCategory({
    required BuildContext context,
    required List<ModelFilter> categories,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: categories.asMap().entries.map((entry) {
            final index = entry.key;
            final e = entry.value;
            return GestureDetector(
              onTap: () => controller.onChangeFilterCategory(index),
              child: Obx(
                () => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  // Tambah padding horizontal
                  margin: const EdgeInsets.only(right: 10),
                  // Tambah margin
                  decoration: BoxDecoration(
                    color: e.isSelected.value // Gunakan e.isSelected.value
                        ? context.colorScheme.surface
                        : context.colorScheme.surface.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(20), // Ubah border radius
                  ),
                  child: Text(
                    e.title,
                    style: context.labelMedium.copyWith(
                      color: e.isSelected.value // Gunakan e.isSelected.value
                          ? context.colorScheme.primary
                          : context.colorScheme.surface,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
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
    late String categoryActive;
    if (controller.searchC.text != '' && controller.isSearch.isTrue) {
      categoryActive = controller.searchC.text;
    } else {
      categoryActive = controller.filterListKategori
          .where((e) => e.isSelected.value)
          .map((v) => v.title)
          .join(', ');
    }
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
              ],
            ),
          ),
          if (itemCount == 0)
            Expanded(
              child: Center(
                child: bookEmpty('Buku $categoryActive masih kosong'),
              ),
            )
          else
            Expanded(
              child: Material(
                child: SmartRefresher(
                  controller: controller.refreshControllerList,
                  enablePullUp: true,
                  onRefresh: controller.onRefreshList,
                  header: const Header(height: 40),
                  footer: const Footer(),
                  onLoading: controller.onLoadingList,
                  child: ListView.builder(
                    itemCount: itemCount,
                    shrinkWrap: true,
                    scrollDirection: scrollDirection,
                    physics: physics,
                    itemBuilder: itemBuilder,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  //
  // Widget filterGender(){
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       FlutterPopupMenuButton(
  //         direction: MenuDirection.values.first,
  //         decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(20)),
  //             color: Colors.white),
  //         popupMenuSize: const Size(120, 120),
  //         child: FlutterPopupMenuIcon(
  //           key: GlobalKey(),
  //           child: Obx(
  //                 () => Text(controller.genreCurrent.value),
  //           ),
  //         ),
  //         children: controller.genreList
  //             .map(
  //               (v) => FlutterPopupMenuItem(
  //             onTap: () => controller.onChangeFilterGenre(v),
  //             child: Padding(
  //               padding:
  //               const EdgeInsets.only(left: 20, bottom: 16),
  //               child: Text(v),
  //             ),
  //           ),
  //         )
  //             .toList(),
  //       ),
  //       const Icon(Icons.keyboard_arrow_down_sharp),
  //     ],
  //   ),
  // }

  PreferredSize bottomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Card(
          elevation: 4,
          child: TextFormField(
            controller: controller.searchC,
            cursorColor: context.colorScheme.onPrimary,
            onChanged: (v) => controller.onChangeSearch(
              value: v,
              isSearch: controller.isSearch,
            ),
            decoration: InputDecoration(
              hintText: 'Cari',
              filled: true,
              fillColor: context.colorScheme.primary,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  KeysAssetsIcons.search,
                  height: 13,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: controller.clearForm,
                  child: SvgPicture.asset(
                    KeysAssetsIcons.close,
                    height: 13,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.onSecondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
