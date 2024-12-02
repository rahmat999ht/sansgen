import 'dart:async';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sansgen/app/modules/riwayat/views/belum_baca.dart';
import 'package:sansgen/app/modules/riwayat/views/sudah_baca.dart';
import 'package:sansgen/utils/ext_string.dart';

import '../../../../keys/env.dart';
import '../../../../model/book/books.dart';
import '../../../../model/history/response_get.dart';
import '../../../../provider/history.dart';
import '../../../../provider/book.dart';
import '../../../routes/app_pages.dart';

class RiwayatController extends GetxController with StateMixin<ModelHistory> {
  final HistoryProvider historyProvider;
  final BookProvider bookProvider;

  RiwayatController({
    required this.historyProvider,
    required this.bookProvider,
  });

  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  final currentIndex = 0.obs;

  void setCurrentIndex(int index) => currentIndex.value = index;

  get getSelectedIndex => currentIndex.value;

  final listPage = [
    const BelumSelesaiDiBaca(),
    const SudahSelesaiDiBaca(),
  ];

  final listBookFinish = <DataBook>[].obs;
  final listBookNotFinish = <DataBook>[].obs;

  void toDetails(DataBook book) {
    Get.toNamed(
      Routes.DETAIL,
      arguments: {
        'uuidBook': book.uuid,
        'nameBook': book.title,
      },
    );
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    await getAllHistory();
    super.onInit();
  }

  Future<bool> getPassengerCategory({bool isRefresh = false}) async {
    if (isRefresh) {
      await getAllHistory(); // Pindahkan dan tambahkan await di sini
    } else {
      return false;
    }
    return true;
  }

// Function untuk onRefresh
  Future<void> onRefresh() async {
    final result = await getPassengerCategory(isRefresh: true);
    if (result) {
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshFailed();
    }
  }

// Function untuk onLoading
  Future<void> onLoading() async {
    final result = await getPassengerCategory();
    if (result) {
      refreshController.loadComplete();
    } else {
      refreshController.loadFailed();
    }
  }

  Future getIdBook(String idBook) async {
    await bookProvider.fetchIdBooks(idBook);
  }

  Future getAllHistory() async {
    historyProvider.fetchHistory().then((response) async {
      if (!response.isOk) {
        final dataEmpty = ModelHistory(
          listBookFinish: listBookFinish,
          listBookNotFinish: listBookNotFinish,
        );
        change(dataEmpty, status: RxStatus.empty());
      }
      final event = modelResponseGetHistoryFromJson(response.bodyString!);
      final bookSelesai = event.data.where((e) => e.isFinished == '1').map((v) {
        return v.book.copyWith(image: v.book.image!.formattedUrl);
      }).toList();

      final bookBelumSelesai =
          event.data.where((e) => e.isFinished == '0').map((v) {
        return v.book.copyWith(image: v.book.image!.formattedUrl);
      }).toList();

      listBookFinish.value = bookSelesai;
      listBookNotFinish.value = bookBelumSelesai;
      log(bookSelesai.toString(), name: 'bookSelesai');
      log(bookBelumSelesai.toString(), name: 'bookBelumSelesai');

      final dataState = ModelHistory(
        listBookFinish: listBookFinish,
        listBookNotFinish: listBookNotFinish,
      );
      change(dataState, status: RxStatus.success());
    }).onError((e, st) {
      change(null, status: RxStatus.error(e.toString()));
    });
  }
}

class ModelHistory {
  final RxList<DataBook> listBookFinish;
  final RxList<DataBook> listBookNotFinish;

  ModelHistory({
    required this.listBookFinish,
    required this.listBookNotFinish,
  });
}
