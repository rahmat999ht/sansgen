import 'package:get/get.dart';
import 'package:sansgen/provider/book.dart';
import 'package:sansgen/provider/history.dart';
import 'package:sansgen/provider/like.dart';
import 'package:sansgen/provider/rate.dart';
import 'package:sansgen/provider/user.dart';

import '../../../../provider/comment.dart';
import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentProvider>(
      () => CommentProvider(),
    );
    Get.lazyPut<LikeProvider>(
      () => LikeProvider(),
    );
    Get.lazyPut<RatingProvider>(
      () => RatingProvider(),
    );
    // Get.lazyPut<ChapterProvider>(
    //   () => ChapterProvider(),
    // );
    Get.lazyPut<BookProvider>(
      () => BookProvider(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.lazyPut<HistoryProvider>(
      () => HistoryProvider(),
    );
    Get.lazyPut<DetailController>(
      () => DetailController(
        commentProvider: Get.find(),
        likeProvider: Get.find(),
        ratingProvider: Get.find(),
        // chapterProvider: Get.find(),
        bookProvider: Get.find(),
        userProvider: Get.find(),
        historyProvider: Get.find(),
      ),
    );
  }
}
