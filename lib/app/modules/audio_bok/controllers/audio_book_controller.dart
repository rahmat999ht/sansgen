import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/keys/api.dart';
import 'package:sansgen/model/book/book.dart';
import 'package:sansgen/provider/chapter.dart';
import 'package:sansgen/utils/ext_string.dart';

import '../../../../keys/env.dart';
import '../../../../model/chapter/data_chapter.dart';
import '../../../../model/user/response_get.dart';
import '../../../../provider/user.dart';
import '../../../../services/audio.dart';
import '../../../../services/common.dart';

class AudioBookController extends GetxController
    with StateMixin<ModelDataAudioPage> {
  final ChapterProvider chapterProvider;
  final UserProvider userProvider;

  AudioBookController({
    required this.chapterProvider,
    required this.userProvider,
  });

  DataIdBook? dataBook;
  var listChapter = <Chapter>[];

  final ScrollController scrollController = ScrollController();
  double scrollSpeed = 20.0; // Kecepatan scroll dalam piksel per detik
  final isPremium = false.obs;

  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final audioPlayer = AudioService();
  String? urlStorage;
  String? urlAudio;

  final Rx<bool> stateAudio = false.obs;
  final Rx<bool> isViewListing = false.obs;
  final Rx<bool> isViewAudio = false.obs;

  final isAutoScrolling = false.obs;

  final Rx<int> currentChapter = 0.obs;

  PositionData? isPositionData;

  void stateViewListing() => isViewListing.value = !isViewListing.value;

  @override
  void onInit() async {
    getArgument();
    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void playAudioIfUrlsAvailable() async {
    urlStorage = baseURL + KeysApi.storage;
    if (urlStorage != null && urlAudio != null) {
      log(urlAudio!, name: 'url audio isNotEmpty');
      audioPlayer.playUrl(urlAudio!); // Tidak perlu await di sini
      isPositionData = await audioPlayer.positionalDataStream.first;
      log(isPositionData.toString(), name: "isPositionData");
      // Hitung scrollSpeed berdasarkan durasi audio
      // final totalDuration = isPositionData?.duration ?? Duration.zero;
      // log(totalDuration.inSeconds.toString(), name: 'totalDuration');
      //
      // final maxScrollExtent = scrollController.position.maxScrollExtent;
      // log(maxScrollExtent.toString(), name: 'maxScrollExtent');
      // log(scrollSpeed.value.toString(), name: 'scrollSpeed');
      //
      // if (totalDuration.inSeconds > 0) {
      //   scrollSpeed.value = maxScrollExtent / totalDuration.inSeconds;
      // } else {
      //   // Atur scrollSpeed ke nilai default jika durasi nol
      //   scrollSpeed.value = 1.0; // Misalnya, 1 piksel per detik
      // }
    } else {
      log('kosong', name: 'url audio isEmpty');
    }
  }

  void startAutoScroll() {
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final duration = Duration(
      milliseconds: (maxScrollExtent / scrollSpeed * 3000).toInt(),
    );
    isAutoScrolling.value = true;
    scrollController.animateTo(
      maxScrollExtent,
      duration: duration,
      curve: Curves.linear,
    );
  }

  void stopAutoScroll() {
    isAutoScrolling.value = false;
    scrollController
        .jumpTo(scrollController.offset); // Menghentikan animasi scroll
  }

  void onAudio() {
    log(stateAudio.value.toString(), name: "stateAudio.value");
    if (stateAudio.isFalse) {
      audioPlayer.play();
      audioPlayer.setVolume(100);
      stateAudio.value = !stateAudio.value;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        startAutoScroll();
      });
    } else {
      audioPlayer.stop();
      audioPlayer.setVolume(0);
      stateAudio.value = !stateAudio.value;
      stopAutoScroll();
    }
  }

  void setCurrentChapter(String value) async {
    currentChapter.value = int.parse(value);
    await getChapter(currentChapter.value.toString());
    Get.back();
  }

  void previousChapter() async {
    if (currentChapter.value == 1) {
      Get.snackbar('info', 'Chapter 1 is the first chapter');
    } else {
      // Cari indexchapter saat ini di listChapter
      final currentIndex = listChapter.indexWhere(
          (chapter) => int.parse(chapter.number) == currentChapter.value);

      // Jika chapter saat ini bukan chapter pertama, pindah ke chapter sebelumnya
      if (currentIndex > 0) {
        final previousChapter = listChapter[currentIndex - 1];
        if (previousChapter.audio == null) {
          Get.snackbar('Gagal', 'Chapter sebelumnya tidak memiliki audio.');
          return;
        }
        currentChapter.value = int.parse(previousChapter.number);
        await getChapter(previousChapter.number);
      }
    }
  }

  void nextChapter() async {
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
        if (nextChapter.audio == null) {
          Get.snackbar('Gagal', 'Chapter selanjutnya tidak memiliki audio.');
          return;
        }
        currentChapter.value = int.parse(nextChapter.number);
        await getChapter(nextChapter.number);
      }
    }
  }

  Future getArgument() async {
    if (Get.arguments != null) {
      final initDataBook = Get.arguments['book'] as DataIdBook;
      final initDataChapter = Get.arguments['numberChapter'] as String;
      listChapter = Get.arguments['listChapter'] as List<Chapter>;

      log(initDataBook.toJson().toString(), name: "initDataBook");
      log(initDataChapter.toString(), name: "initDataChapter");
      log(listChapter.toString(), name: "listChapter");

      currentChapter.value = int.parse(initDataChapter);
      // currentIdChapter.value = initDataChapter.id.toString();
      dataBook = initDataBook;
      await getChapter(currentChapter.value.toString());
      await getUserLogin();
    } else {
      log("kosong", name: 'arguments');
    }
  }

  Future getChapter(
    String numberChapter,
  ) async {
    // setCurrentIdChapterByNumber(numberChapter);
    chapterProvider
        .fetchIdChapter(
      idBook: dataBook!.uuid,
      idChapter: currentChapter.value.toString(),
    )
        .then((v) {
      final dataPage = ModelDataAudioPage(
        dataBook: dataBook!.copyWith(image: dataBook!.image),
        dataChapter: v.data,
      );
      urlAudio = v.data.audio!.formattedUrl;
      log(urlAudio!, name: 'Data urlAudio');
      change(dataPage, status: RxStatus.success());
      if (urlAudio == null || urlAudio == '') {
        isViewAudio.value = false;
      } else {
        isViewAudio.value = true;
        playAudioIfUrlsAvailable(); // Coba putar music setelah urlAudio tersedia
      }
    }).onError((e, st) {
      change(null, status: RxStatus.error(e.toString()));
    });
  }

  Future getUserLogin() async {
    await userProvider.fetchUserId().then((response) {
      if (!response.isOk) {
        isPremium.value = false;
        return;
      }
      final userData = modelResponseUserFromJson(response.bodyString!);
      if (userData.data != null && userData.data!.isPremium == '1') {
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

class ModelDataAudioPage {
  final DataIdBook dataBook;
  final DataChapter dataChapter;

  ModelDataAudioPage({required this.dataBook, required this.dataChapter});
}
