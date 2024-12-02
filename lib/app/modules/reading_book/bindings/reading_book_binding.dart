import 'package:get/get.dart';
import 'package:sansgen/provider/focus.dart';

import '../../../../provider/chapter.dart';
import '../../../../provider/history.dart';
import '../../../../provider/user.dart';
import '../controllers/reading_book_controller.dart';

class ReadingBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChapterProvider>(
      () => ChapterProvider(),
    );
    Get.lazyPut<FocusProvider>(
      () => FocusProvider(),
    );
    Get.lazyPut<HistoryProvider>(
      () => HistoryProvider(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.lazyPut<ReadingBookController>(
      () => ReadingBookController(
        chapterProvider: Get.find(),
        focusProvider: Get.find(),
        historyProvider: Get.find(),
        userProvider: Get.find(),
      ),
    );
  }
}
