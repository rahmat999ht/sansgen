import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';

class BookProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  Future<Response> fetchIdBooks(String id) async {
    final String urlIdBooks = '${KeysApi.books}/$id';
    log(urlIdBooks, name: "data url IdBooks");
    return get(urlIdBooks);
  }

  Future<Response> fetchBooks() async {
    const String urlBooks = KeysApi.books;
    log(urlBooks, name: "data url Books");
    return get(urlBooks);
  }

  Future<Response> fetchBooksPopuler() async {
    const String urlBooksPopuler = KeysApi.books + KeysApi.populer;
    log(urlBooksPopuler, name: "data url book populer");
    return get(urlBooksPopuler);
  }

  @override
  void onInit() {
    httpClient.baseUrl = baseURL + KeysApi.api;
    super.onInit();
  }
}
