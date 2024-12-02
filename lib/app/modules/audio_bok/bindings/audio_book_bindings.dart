import 'package:get/get.dart';
import 'package:sansgen/app/modules/audio_bok/controllers/audio_book_controller.dart';
import 'package:sansgen/provider/chapter.dart';
import 'package:sansgen/provider/user.dart';

class AudioBookBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChapterProvider>(
      () => ChapterProvider(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.lazyPut<AudioBookController>(
      () => AudioBookController(
        chapterProvider: Get.find(),
        userProvider: Get.find(),
      ),
    );
  }
}
