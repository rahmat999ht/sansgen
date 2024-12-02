import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sansgen/model/focus/request_put.dart';
import 'package:sansgen/utils/ext_int.dart';

import '../../../../keys/api.dart';
import '../../../../keys/env.dart';
import '../../../../model/book/book.dart';
import '../../../../model/chapter/data_chapter.dart';
import '../../../../model/history/request_post.dart';
import '../../../../model/user/response_get.dart';
import '../../../../provider/chapter.dart';
import '../../../../provider/focus.dart';
import '../../../../provider/history.dart';
import '../../../../provider/user.dart';
import '../../../../services/audio.dart';

class ReadingBookController extends GetxController
    with StateMixin<ModelDataReadingPage> {
  final ChapterProvider chapterProvider;
  final FocusProvider focusProvider;
  final HistoryProvider historyProvider;
  final UserProvider userProvider;

  ReadingBookController({
    required this.chapterProvider,
    required this.focusProvider,
    required this.historyProvider,
    required this.userProvider,
  });

  final musicPlayer = AudioService();
  final stopwatchReading = Stopwatch();
  final stopwatchFocus = Stopwatch();

  final ScrollController scrollController = ScrollController();
  double scrollSpeed = 20.0; // Kecepatan scroll dalam piksel per detik
  final isAutoScrolling = false.obs;
  final isAppBarVisible = true.obs;
  final isBottomBarVisible = true.obs;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  DataIdBook? dataBook;
  var listChapter = <Chapter>[];

  final Rx<int> currentChapter = 0.obs;

  // final Rx<String> currentIdChapter = ''.obs;
  final Rx<bool> stateMusic = false.obs;
  final Rx<bool> isViewMusic = false.obs;
  String? urlStorage;
  String? urlMusic;

  final isPremium = false.obs;

  // int initDuration = 10;

  // final CountDownController controllerTimer = CountDownController();
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  @override
  void onInit() async {
    log('init Reading', name: 'on init');
    stopwatchReading.start();
    getArgument();
    // WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() async {
    await sendDataFocus();
    musicPlayer.dispose();
    super.onClose();
  }

  void startAutoScroll() {
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final duration =
        Duration(milliseconds: (maxScrollExtent / scrollSpeed * 2000).toInt());
    isAutoScrolling.value = true;
    isAppBarVisible.value = false;
    isBottomBarVisible.value = false;
    scrollController.animateTo(
      maxScrollExtent,
      duration: duration,
      curve: Curves.linear,
    );
  }

  void stopAutoScroll() {
    isAutoScrolling.value = false;
    isAppBarVisible.value = true;
    isBottomBarVisible.value = true;
    scrollController
        .jumpTo(scrollController.offset); // Menghentikan animasi scroll
  }

  Future sendHistory({
    required int lastChapter,
    required String idChapter,
  }) async {
    final request = ModelRequestPostHistory(lastChapter: lastChapter);
    historyProvider.postHistory(
      uuidBook: dataBook!.uuid,
      idChapter: idChapter,
      request: request,
    );
  }

  Future sendDataFocus() async {
    stopwatchReading.stop();
    stopwatchFocus.stop();

    final readings = stopwatchReading.elapsedMilliseconds.toFormattedTime();

    final focus = stopwatchFocus.elapsedMilliseconds.toFormattedTime();

    final request = ModelRequestPutFocus(
      readings: readings,
      // manyBooks: manyBooks,
      focus: focus,
    );

    log(request.toJson().toString(), name: 'Send data');

    focusProvider.putFocusCurrent(request);
  }

  void openTimer(Widget widget) {
    Get.defaultDialog(
      title: "",
      content: widget,
    );
  }

  void onMusic() {
    log(stateMusic.value.toString(), name: "stateMusic.value");
    if (stateMusic.isFalse) {
      musicPlayer.play();
      musicPlayer.setVolume(100);
      stateMusic.value = !stateMusic.value;
      stopwatchFocus.start();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        startAutoScroll();
      });
    } else {
      musicPlayer.stop();
      musicPlayer.setVolume(0);
      stateMusic.value = !stateMusic.value;
      stopwatchFocus.stop();
      stopAutoScroll();
      final focus = stopwatchFocus.elapsedMilliseconds.toFormattedTime();
      log(focus, name: 'focus');
    }
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void setCurrentChapter(String value) {
    currentChapter.value = int.parse(value);
    getChapter(currentChapter.value.toString());
    Get.back();
  }

  Future previousChapter() async {
    if (currentChapter.value == 1) {
      Get.snackbar('info', 'Chapter 1 is the first chapter');
    } else {
      // Cari indexchapter saat ini di listChapter
      final currentIndex = listChapter.indexWhere(
          (chapter) => int.parse(chapter.number) == currentChapter.value);

      // Jika chapter saat ini bukan chapter pertama, pindah ke chapter sebelumnya
      if (currentIndex > 0) {
        final previousChapter = listChapter[currentIndex - 1];
        currentChapter.value = int.parse(previousChapter.number);
        await getChapter(previousChapter.number);
      }
    }
  }

  Future nextChapter() async {
    sendHistory(
      lastChapter: currentChapter.value,
      idChapter: currentChapter.value.toString(),
    );
    if (isPremium.value == false && currentChapter.value >= 3) {
      Get.snackbar(
        'info',
        'Anda belum bisa membuka chapter selanjutnya, karena akun anda belum premium',
      );
    } else if (currentChapter.value == dataBook!.manyChapters) {
      Get.snackbar(
          'info', 'Chapter ${dataBook!.manyChapters} is the last chapter');
    } else {
      // Cari index chapter saat ini di listChapter
      final currentIndex = listChapter.indexWhere(
          (chapter) => int.parse(chapter.number) == currentChapter.value);

      // Jika chapter saat ini bukan chapter terakhir, pindah ke chapter berikutnya
      if (currentIndex < listChapter.length - 1) {
        final nextChapter = listChapter[currentIndex + 1];
        currentChapter.value = int.parse(nextChapter.number);
        await getChapter(nextChapter.number);
      }
    }
  }

  void playAudioIfUrlsAvailable() async {
    urlStorage = baseURL + KeysApi.storage;
    if (urlStorage != null && urlMusic != null) {
      log(urlMusic!, name: 'url music isNotEmpty');
      musicPlayer.playerStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          musicPlayer.jumToDuration(Duration.zero); // Kembali ke awal
          musicPlayer.play(); // Putar ulang
        }
      });
      musicPlayer.playUrl(urlMusic!); // Tidak perlu await di sini
    } else {
      log('kosong', name: 'url music isEmpty');
    }
  }

  Future getArgument() async {
    if (Get.arguments != null) {
      final initDataBook = Get.arguments['book'] as DataIdBook;
      final initDataChapter = Get.arguments['numberChapter'] as String;
      listChapter = Get.arguments['listChapter'] as List<Chapter>;

      log(initDataBook.toJson().toString(), name: "initDataBook");
      // log(initDataChapter.toJson().toString(), name: "initDataChapter");
      log(listChapter.toString(), name: "listChapter");
      dataBook = initDataBook;

      currentChapter.value = int.parse(initDataChapter);
      // currentIdChapter.value = initDataChapter.id.toString();
      await getChapter(currentChapter.value.toString());
      await getUserLogin();
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future getChapter(String numberChapter) async {
    change(null, status: RxStatus.loading());
    chapterProvider
        .fetchIdChapter(
      idBook: dataBook!.uuid,
      idChapter: currentChapter.value.toString(),
    )
        .then((v) {
      final dataPage = ModelDataReadingPage(
        dataBook: dataBook!.copyWith(music: dataBook!.music),
        dataChapter: v.data,
      );
      urlMusic = dataBook!.music;
      log(urlMusic.toString(), name: 'Data urlMusic');
      log(v.data.toJson().toString(), name: 'Data dataChapter');
      change(dataPage, status: RxStatus.success());
      if (urlMusic == null || urlMusic == '') {
        isViewMusic.value = false;
      } else {
        isViewMusic.value = true;
        playAudioIfUrlsAvailable(); // Coba putar music setelah urlMusic tersedia
      }
    }).onError((e, st) {
      log(e.toString() + st.toString(), name: 'pesan error chapter');
      change(null, status: RxStatus.error(e.toString()));
    });
  }

  Future getUserLogin() async {
    await userProvider.fetchUserId().then((response) {
      if(!response.isOk){
        isPremium.value = false;
        return;
      }
      final userData = modelResponseUserFromJson(response.bodyString!);
      if (userData.data!.isPremium == '1') {
        log('kosong', name: 'data isPremium');
        isPremium.value = true;
      } else {
        log('ada', name: 'data isPremium');
        isPremium.value = false;
      }
    }).onError((e, st) {
      isPremium.value = false;
    });
  }
}

class ModelDataReadingPage {
  final DataIdBook dataBook;
  final DataChapter dataChapter;

  ModelDataReadingPage({required this.dataBook, required this.dataChapter});
}
