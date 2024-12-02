import 'dart:developer';

import 'package:get/get.dart';

import '../../../../model/book/books.dart';
import '../../../routes/app_pages.dart';

class ListLainnyaController extends GetxController
    with StateMixin<List<DataBook>> {
  ListLainnyaController();

  var bookList = <DataBook>[];

  void toDetails(DataBook book) {
    Get.toNamed(Routes.DETAIL, arguments: {
      'uuidBook': book.uuid,
    });
  }

  @override
  void onInit() {
    if (Get.arguments == null) {
      bookList = [];
      log('argument kosong');
    } else {
      bookList = Get.arguments;
    }

    super.onInit();
  }
}
