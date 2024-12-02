import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sansgen/utils/ext_string.dart';

import '../../../../model/book/books.dart';
import '../../../../model/book/books_all.dart';
import '../../../../model/category/response_get.dart';
import '../../../../provider/book.dart';
import '../../../../provider/category.dart';
import '../../../routes/app_pages.dart';

class KategoriController extends GetxController
    with StateMixin<List<DataBook>> {
  final BookProvider bookProvider;
  final CategoryProvider categoryProvider;

  KategoriController({
    required this.bookProvider,
    required this.categoryProvider,
  });

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final RefreshController refreshControllerList =
      RefreshController(initialRefresh: false);

  // final genreList = <String>[
  //   'Laki-laki',
  //   'Perempuan',
  // ];

  final genreCurrent = ''.obs;

  List<DataBook> bookList = <DataBook>[];
  final searchC = TextEditingController();
  var filterListKategori = <ModelFilter>[].obs;

  // var dataModel = ModelCategoryPage();

  final isSearch = false.obs;

  void setGenre(String v) => genreCurrent.value = v;

  void toDetails(DataBook book) {
    Get.toNamed(Routes.DETAIL, arguments: {
      'uuidBook': book.uuid,
      'nameBook': book.title,
    });
  }

  @override
  void onInit() async {
    await fetchData();
    // setGenre(genreList[0]);
    super.onInit();
  }

  Future<bool> getPassengerCategory({bool isRefresh = false}) async {
    if (isRefresh) {
      await fetchData(); // Pindahkan dan tambahkan await di sini
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

  // Function untuk onRefresh
  Future<void> onRefreshList() async {
    final result = await getPassengerCategory(isRefresh: true);
    if (result) {
      refreshControllerList.refreshCompleted();
    } else {
      refreshControllerList.refreshFailed();
    }
  }

// Function untuk onLoading
  Future<void> onLoadingList() async {
    final result = await getPassengerCategory();
    if (result) {
      refreshControllerList.loadComplete();
    } else {
      refreshControllerList.loadFailed();
    }
  }

  Future clearForm() async {
    searchC.clear();
    await fetchData();
  }

  Future<void> fetchData() async {
    try {
      final resultBooks = await bookProvider.fetchBooks();
      final resultCategories = await categoryProvider.fetchCategory();

      if (resultBooks.isOk && resultCategories.isOk) {
        final bookData = booksModelFromJson(resultBooks.bodyString!);
        final dataCategories =
            modelResponseGetCategoryFromJson(resultCategories.bodyString!);

        final books = bookData.data.map((e) {
          return e.copyWith(image: e.image!.formattedUrl);
        }).toList();
        bookList = books;
        final categories =
            dataCategories.categories.map((e) => e.name).toList();
        final kategoriList = ['All', ...categories];
        filterListKategori.value = kategoriList
            .map(
              (e) => ModelFilter(title: e, isSelected: false.obs),
            )
            .toList();
        filterListKategori[0].isSelected.value = true;
        change(
          bookList,
          status: RxStatus.success(),
        );
      } else {
        change(null, status: RxStatus.empty());
        log('Data buku atau kategori kosong', name: 'data kosong');
      }
    } catch (err) {
      change(null, status: RxStatus.error(err.toString()));
      log(err.toString(), name: 'Error fetchData');
    }
  }

  // void onChangeFilterGenre(String v) {
  //   final onFilter = bookList.where((e) => e.gender == v).toList();
  //   setGenre(v);
  //   change(onFilter, status: RxStatus.success());
  // }

  void onChangeSearch({required String value, required RxBool isSearch}) {
    if (value.isNotEmpty) {
      isSearch.value = true;
    } else {
      isSearch.value = false;
      fetchData();
    }
    final onSearch = value.isEmpty
        ? bookList
        : bookList
            .where((element) =>
                element.title.toLowerCase().contains(value.toLowerCase()) ||
                element.synopsis.toLowerCase().contains(value.toLowerCase()) ||
                element.publisher.toLowerCase().contains(value.toLowerCase()) ||
                element.writer.toLowerCase().contains(value.toLowerCase()) ||
                element.gender.toLowerCase().contains(value.toLowerCase()))
            .toList();
    change(onSearch, status: RxStatus.success());
  }

  void onChangeFilterCategory(int index) {
    // Toggle nilai isSelected untuk filter yang dipilih
    filterListKategori[index].isSelected.value =
        !filterListKategori[index].isSelected.value;

    // Periksa apakah semua filter selain "All" bernilai false
    final allFalse = filterListKategori
        .skip(1) // Lewati filter "All"
        .every((e) => !e.isSelected.value);

    if (allFalse) {
      // Set "All" menjadi true
      fetchData(); // Tampilkan semua buku jika 'All' dipilih
      filterListKategori[0].isSelected.value = true;
    }

    // Jika 'All' dipilih, hapus pilihan pada filter lainnya
    if (index == 0 && filterListKategori[index].isSelected.value) {
      for (var i = 1; i < filterListKategori.length; i++) {
        filterListKategori[i].isSelected.value = false;
      }
    } else if (filterListKategori[index].isSelected.value) {
      // Jika filter selain 'All' dipilih, hapus pilihan pada 'All'
      filterListKategori[0].isSelected.value = false;
    }

    // Terapkan filter berdasarkan pilihan yangbaru
    final selectedFilters = filterListKategori
        .where((e) => e.isSelected.value)
        .map((e) => e.title)
        .toList();

    if (selectedFilters.contains('All')) {
      fetchData(); // Tampilkan semua buku jika 'All' dipilih
    } else {
      final filteredBooks = bookList
          .where((book) =>
              selectedFilters.any((filter) => filter == book.category))
          .toList();
      change(filteredBooks, status: RxStatus.success());
    }
  }
}

class ModelFilter {
  final String title;
  Rx<bool> isSelected;

  ModelFilter({
    required this.title,
    required this.isSelected,
  });
}

class ModelCategoryPage {
  final List<DataBook>? books;
  final List<ModelFilter>? categories;

  ModelCategoryPage({this.books, this.categories});

  ModelCategoryPage copyWith({
    List<DataBook>? books,
    List<ModelFilter>? categories,
  }) {
    return ModelCategoryPage(
      books: books ?? this.books,
      categories: categories ?? this.categories,
    );
  }
}
