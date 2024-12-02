import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../model/book/book_by_id.dart';
import '../../../../model/user/response_get.dart';
import '../../../../provider/book.dart';
import '../../../../provider/user.dart';
import '../../../../model/comment/request_post.dart';
import '../../../../model/history/response_by_id_book.dart';
import '../../../../model/ratings/request_post.dart';
import '../../../../provider/comment.dart';
import '../../../../provider/history.dart';
import '../../../../provider/like.dart';
import '../../../../provider/rate.dart';
import '../../../../services/prefs.dart';
import '../../../../model/book/book.dart';
import '../component/content_chapter.dart';
import '../component/content_comment.dart';

class DetailController extends GetxController with StateMixin<ModelDataDetail> {
  final CommentProvider commentProvider;
  final LikeProvider likeProvider;
  final RatingProvider ratingProvider;
  final BookProvider bookProvider;
  final UserProvider userProvider;
  final HistoryProvider historyProvider;

  DetailController({
    required this.commentProvider,
    required this.likeProvider,
    required this.ratingProvider,
    required this.bookProvider,
    required this.userProvider,
    required this.historyProvider,
  });

  final prefServices = PrefService();

  final isPremium = false.obs;

  late String uuidBook;
  late String nameBook;
  final scrollController = ScrollController();
  final commentFormC = TextEditingController();
  final isLikeState = false.obs;
  final ratingCurrent = 0.0.obs;

  late DataIdBook dataIdBook;
  final listComments = <Comment>[].obs;
  final listLike = <Like>[].obs;
  final listChapter = <Chapter>[].obs;
  final Rx<double?> averageRate = 0.0.obs;

  RxList<int> readChapterIds = <int>[].obs; // Gunakan ID chapter,

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void backToDashboard() {
    Get.back();
  }

  @override
  void onInit() async {
    if (Get.arguments != null) {
      log('Get argument ada', name: 'onInit');
      uuidBook = Get.arguments['uuidBook'];
      nameBook = Get.arguments['nameBook'];
      await prefServices.prefInit();
      await fetchDataDetail();
      // readChapterIds.value = [];
      await fetchReadChapters();
      log(uuidBook, name: 'idBook');
    } else {
      // Tangani kasus ketika Get.arguments kosong
      Get.snackbar('Error', 'Data buku tidak ditemukan');
      Get.back();
    }
    super.onInit();
  }

  Future<bool> getPassengerDetails({bool isRefresh = false}) async {
    if (isRefresh) {
      await fetchDataDetail(); // Panggil fungsi untuk mengambil semua data
      await fetchReadChapters();
    } else {
      return false;
    }
    return true;
  }

// Function untuk onRefresh
  Future<void> onRefresh() async {
    final result = await getPassengerDetails(isRefresh: true);
    if (result) {
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshFailed();
    }
  }

// Function untuk onLoading
  Future<void> onLoading() async {
    final result = await getPassengerDetails();
    if (result) {
      refreshController.loadComplete();
    } else {
      refreshController.loadFailed();
    }
  }

  Future<void> fetchReadChapters() async {
    await historyProvider.fetchHistoryByIdBook(uuidBook).then((response) {
      if (response.statusCode == 200) {
        final allHistory =
            modelResponseHistoryByIdBookFromJson(response.bodyString!);
        log(response.bodyString.toString(), name: 'response history chapter');
        if (allHistory.data.chapters != null &&
            allHistory.data.chapters!.isNotEmpty) {
          readChapterIds.value =
              allHistory.data.chapters!.map((e) => e.id).toList();
        } else {
          readChapterIds.value = [];
        }
      } else {
        readChapterIds.value = [];
      }
    });
  }

  void tapViewBottomSheetChapter(
      List<Chapter> listChapter, BuildContext context) {
    Get.bottomSheet(
      contentBottomSheetChapter(
        context: context,
        listChapter: listChapter,
        isPremium: isPremium.value,
        dataBook: state!.dataBook,
        readChapterIds: readChapterIds,
      ),
    );
  }

  void tapViewRating() {
    Get.defaultDialog(
      title: 'Berikan rating anda',
      onConfirm: () async {
        await addRating(ratingCurrent.value);
        Get.back();
      },
      textConfirm: 'Berikan',
      onCancel: Get.back,
      textCancel: 'Batal',
      content: Obx(
        () => RatingBar.builder(
          initialRating: ratingCurrent.value,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemSize: 28,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            ratingCurrent.value = rating;
            log(rating.toString(), name: 'rating');
          },
        ),
      ),
    );
  }

  void tapViewBottomSheetComment(
    RxList<Comment> listComment,
    BuildContext ctx,
  ) {
    // listComment.sort((a, b) => a.time.compareTo(b.time));
    Get.bottomSheet(
      contentBottomSheetComment(
        context: ctx,
        listComment: listComment,
        scrollController: scrollController,
        controller: commentFormC,
        onTapSend: addComment,
      ),
      ignoreSafeArea: false,
      isScrollControlled: true,
    ).then((_) {
      // Setelah bottom sheet ditampilkan
      // Gulir ke bawah
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future addRating(double rate) async {
    final request = ModelRequestPostRate(rate: rate);
    try {
      await ratingProvider.postRatingBook(
        uuidBook: uuidBook,
        request: request,
      );
      // Perbarui averageRate di state
      await getAllRating(); // Perbarui averageRate
      final currentData = state; // Ambil state saat ini
      if (currentData != null) {
        change(
          currentData.copyWith(averageRate: averageRate.value),
          status: RxStatus.success(),
        );
      }
    } catch (e) {
      Get.snackbar('info', 'Anda sudah memberikan Rating');
    }
  }

  Future addComment() async {
    if (commentFormC.text == '') {
      return Get.snackbar('info', 'tulis komentar anda');
    }
    final request = ModelRequestPostComment(comment: commentFormC.text);
    try {
      await commentProvider.postCommentBook(
        uuidBook: uuidBook,
        request: request,
      );
      // Perbarui listComments di state
      final currentData = state;
      if (currentData != null) {
        await getAllComment(); // Perbarui listComments
        change(
          currentData.copyWith(comments: listComments),
          status: RxStatus.success(),
        );
        commentFormC.clear();
      }
    } catch (e) {
      Get.snackbar('info', 'gagal mengirim komentar');
    }
  }

  Future addLike() async {
    try {
      await likeProvider.postLikeBook(uuidBook: uuidBook);
      // Perbarui listLikes dan isLikeState di state
      final currentData = state;
      if (currentData != null) {
        await getAllLike(); // Perbarui listLikes dan isLikeState
        change(
          currentData.copyWith(likes: listLike, isLiked: isLikeState.value),
          status: RxStatus.success(),
        );
      }
    } catch (e) {
      Get.snackbar('info', 'gagal mengirim like');
    }
  }

  Future getAllComment() async {
    await bookProvider.fetchIdBooks(uuidBook).then((response) {
      if (!response.isOk) {
        log('comment kosong', name: 'data comment');
        listComments.value = [];
      } else {
        final bookData = modelBookByIdFromJson(response.bodyString!);
        log('comment ada', name: 'data comment');
        listComments.value = bookData.data.comments;
        final currentData = state;
        if (currentData != null) {
          change(
            currentData.copyWith(averageRate: averageRate.value),
            status: RxStatus.success(),
          );
        }
      }
    }).onError((e, st) {
      listComments.value = [];
    });
  }

  Future getAllLike() async {
    await bookProvider.fetchIdBooks(uuidBook).then((response) {
      final currentData = state;
      if (!response.isOk) {
        log('like kosong', name: 'data like');
        listLike.value = [];
      } else {
        log('like ada', name: 'data like');
        final bookData = modelBookByIdFromJson(response.bodyString!);
        listLike.value = bookData.data.likes;
        final idUser = prefServices.getUserUuid;
        final isLike = bookData.data.likes.where((e) => e.user.uuid == idUser);
        if (isLike.isEmpty) {
          isLikeState.value = false;
        } else {
          isLikeState.value = true;
        }
        change(
          currentData!.copyWith(likes: listLike, isLiked: isLikeState.value),
          status: RxStatus.success(),
        );
      }
    }).onError((e, st) {
      listLike.value = [];
    });
  }

  Future getAllRating() async {
    await bookProvider.fetchIdBooks(uuidBook).then((response) {
      if (!response.isOk) {
        log('comment kosong', name: 'data like');
        averageRate.value = 0.0;
      } else {
        final bookData = modelBookByIdFromJson(response.bodyString!);
        log('comment ada', name: 'data like');
        averageRate.value = bookData.data.averageRate;
      }
      change(
        state!.copyWith(averageRate: averageRate.value),
        status: RxStatus.success(),
      );
    }).onError((e, st) {
      listLike.value = [];
    });
  }

  Future getAllChapter() async {
    await bookProvider.fetchIdBooks(uuidBook).then((response) {
      if (!response.isOk) {
        log('comment kosong', name: 'data listChapter');
        listChapter.value = [];
      } else {
        log('comment ada', name: 'data listChapter');
        final bookData = modelBookByIdFromJson(response.bodyString!);
        listChapter.value = bookData.data.chapters;
        listChapter
            .sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
      }
      change(
        state!.copyWith(chapters: listChapter),
        status: RxStatus.success(),
      );
    }).onError((e, st) {
      listLike.value = [];
    });
  }

  // Future getUserLogin() async {
  //   await userProvider.fetchUserId().then((v) {
  //     if (v.data != null && v.data!.isPremium == '1') {
  //       log('kosong', name: 'data isPremium');
  //       isPremium.value = true;
  //     } else {
  //       log('ada', name: 'data isPremium');
  //       isPremium.value = false;
  //     }
  //     final currentData = state;
  //     change(
  //       currentData!.copyWith(isPremium: isPremium.value),
  //       status: RxStatus.success(),
  //     );
  //   }).onError((e, st) {
  //     isPremium.value = false;
  //   });
  // }

  Future<void> fetchDataDetail() async {
    try {
      final resultIdBook = await bookProvider.fetchIdBooks(uuidBook);
      final resultUser = await userProvider.fetchUserId();

      if (resultIdBook.isOk && resultUser.isOk) {
        final bookData = modelBookByIdFromJson(resultIdBook.bodyString!);
        final userData = modelResponseUserFromJson(resultUser.bodyString!);

        listComments.value = bookData.data.comments;
        listLike.value = bookData.data.likes;
        averageRate.value = bookData.data.averageRate;
        listChapter.value = bookData.data.chapters;

        final isLike = bookData.data.likes
            .where((e) => e.user.uuid == prefServices.getUserUuid)
            .isNotEmpty;
        isPremium.value = userData.data?.isPremium == '1';

        final dataDetail = ModelDataDetail(
          dataBook: bookData.data,
          comments: listComments,
          likes: listLike,
          averageRate: averageRate.value!,
          chapters: listChapter,
          isPremium: isPremium.value,
          isLiked: isLike,
        );

        change(dataDetail, status: RxStatus.success());
      } else {
        Get.snackbar('Error', 'Gagal memuat data buku');
        change(null, status: RxStatus.error('Gagal memuat data buku'));
      }
    } catch (e) {
      log(e.toString(), name: 'fetchDataDetail error');
      change(null, status: RxStatus.error('Error fetching book details'));
    }
  }
}

// Model data untuk DetailController (dengan tambahan isLiked)
class ModelDataDetail {
  final DataIdBook dataBook;
  final RxList<Comment> comments;
  final RxList<Like> likes;
  final double averageRate;
  final RxList<Chapter> chapters;
  final bool isPremium;
  final bool isLiked; // Tambahkan properti isLiked

  ModelDataDetail({
    required this.dataBook,
    required this.comments,
    required this.likes,
    required this.averageRate,
    required this.chapters,
    required this.isPremium,
    required this.isLiked, // Inisialisasi isLiked
  });

  // Tambahkan metode copyWith untuk memperbarui state
  ModelDataDetail copyWith({
    DataIdBook? dataBook,
    RxList<Comment>? comments,
    RxList<Like>? likes,
    double? averageRate,
    RxList<Chapter>? chapters,
    bool? isPremium,
    bool? isLiked,
  }) {
    return ModelDataDetail(
      dataBook: dataBook ?? this.dataBook,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
      averageRate: averageRate ?? this.averageRate,
      chapters: chapters ?? this.chapters,
      isPremium: isPremium ?? this.isPremium,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
