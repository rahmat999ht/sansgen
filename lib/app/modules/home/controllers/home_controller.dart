import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sansgen/app/modules/dashboard/controllers/dashboard_controller.dart';

import 'package:sansgen/provider/book.dart';
import 'package:sansgen/provider/focus.dart';
import 'package:sansgen/utils/ext_string.dart';

import '../../../../keys/env.dart';
import '../../../../model/book/books.dart';
import '../../../../model/book/books_all.dart';
import '../../../../model/focus/data_focus.dart';
import '../../../../model/user/response_get.dart';
import '../../../../model/user/user.dart';
import '../../../../provider/best_for_you.dart';
import '../../../../provider/user.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController with StateMixin<ModelDataHome> {
  final BookProvider bookProvider;
  final BestForYouProvider bestForYouProvider;
  final UserProvider userProvider;
  final FocusProvider focusProvider;

  HomeController({
    required this.bookProvider,
    required this.bestForYouProvider,
    required this.userProvider,
    required this.focusProvider,
  });

  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  // final List<DataBook> bookList = List.generate(7, (index) => book);
  List<DataBook> bookList = <DataBook>[];
  final ScrollController scrollController = ScrollController();
  final isAppBarVisible = true.obs;
  var appBarData = AppBarData(
    name: '-',
    image: '-',
    reading: '-',
    books: '-',
    focus: '-',
  ).obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final dashController = Get.find<DashboardController>();

  @override
  void onInit() async {
    await fetchDataHome();
    super.onInit();
  }

  void toDetails(DataBook book) {
    Get.toNamed(Routes.DETAIL, arguments: {
      'uuidBook': book.uuid,
      'nameBook': book.title,
    });
  }

  Future<bool> getPassengerHome({bool isRefresh = false}) async {
    if (isRefresh) {
      await fetchDataHome();
    } else {
      return false;
    }
    return true;
  }

// Function untuk onRefresh
  Future<void> onRefresh() async {
    final result = await getPassengerHome(isRefresh: true);
    if (result) {
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshFailed();
    }
  }

// Function untuk onLoading
  Future<void> onLoading() async {
    final result = await getPassengerHome();
    if (result) {
      refreshController.loadComplete();
    } else {
      refreshController.loadFailed();
    }
  }

  Future<void> fetchDataHome() async {
    try {
      late List<DataBook> populerList;
      late List<DataBook> bestForYouList;
      late ModelUser infoUser;
      late DataFocus infoFocus;

      final resultPopuler = await bookProvider.fetchBooksPopuler();
      final resultInfoUser = await userProvider.fetchUserId();
      final resultBestForYou = await bestForYouProvider.fetchBooksBestForYou();
      final resultFocus = await focusProvider.fetchFocusByUser();

      if (!resultPopuler.isOk) {
        populerList = [];
        log('Permintaan buku populer gagal', name: 'data kosong');
      } else {
        final bookData = booksModelFromJson(resultPopuler.bodyString!);
        populerList = bookData.data.map((e) {
          return e.copyWith(image: e.image!.formattedUrl);
        }).toList();
        // log(populerList.map((e) => e.toJson()).toString(), name: 'populerList');
      }
      if (!resultBestForYou.isOk) {
        bestForYouList = [];
        log('Permintaan buku terbaik untuk Anda gagal', name: 'data kosong');
      } else {
        final bookData = booksModelFromJson(resultBestForYou.bodyString!);
        bestForYouList = bookData.data.map((e) {
          return e.copyWith(image: e.image!.formattedUrl);
        }).toList();
        log(
          bestForYouList.map((e) => e.toJson()).toString(),
          name: 'bestForYouList',
        );
      }
      if (!resultInfoUser.isOk) {
        infoUser = ModelUser.fromJson({});
        log('Permintaan informasi pengguna gagal', name: 'data kosong');
      } else {
        final userData = modelResponseUserFromJson(resultInfoUser.bodyString!);

        infoUser =
            userData.data!.copyWith(image: userData.data!.image!.formattedUrl);
        appBarData.value = appBarData.value.copyWith(
          name: infoUser.name,
          image: infoUser.image,
        );
        // log(infoUser.toJson().toString(), name: 'infoUser');
      }
      if (resultFocus.data == null) {
        infoFocus = DataFocus.fromJson({});
      } else {
        infoFocus = resultFocus.data!;
        appBarData.value = appBarData.value.copyWith(
          reading: resultFocus.data!.readings,
          focus: resultFocus.data!.focus,
          books: resultFocus.data!.manyBooks,
        );
      }
      if (populerList.isEmpty &&
          bestForYouList.isEmpty &&
          infoUser == ModelUser.fromJson({})) {
        change(null, status: RxStatus.empty());
        log('Semua data kosong', name: 'data kosong');
      }
      log(appBarData.toJson().toString(), name: 'data appbar');
      change(
        ModelDataHome(
          populer: populerList,
          bestForYou: bestForYouList,
          profil: infoUser,
          focus: infoFocus,
        ),
        status: RxStatus.success(),
      );
    } catch (err) {
      log(err.toString(), name: 'pesan error home controller');
      change(null, status: RxStatus.error(err.toString()));
    }
  }
}

class ModelDataHome {
  final List<DataBook> populer;
  final List<DataBook> bestForYou;
  final ModelUser profil;
  final DataFocus focus;

  ModelDataHome({
    required this.populer,
    required this.bestForYou,
    required this.profil,
    required this.focus,
  });
}

class AppBarData {
  final String name;
  final String image;
  final String reading;
  final String books;
  final String focus;

  AppBarData({
    required this.name,
    required this.image,
    required this.reading,
    required this.books,
    required this.focus,
  });

  AppBarData copyWith({
    String? name,
    String? image,
    String? reading,
    String? books,
    String? focus,
  }) {
    return AppBarData(
      name: name ?? this.name,
      image: image ?? this.image,
      reading: reading ?? this.reading,
      books: books ?? this.books,
      focus: focus ?? this.focus,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'reading': reading,
      'books': books,
      'focus': focus,
    };
  }
}
