import 'package:get/get.dart';

class ModelPreferenci {
  final int id;
  final String title;
  Rx<bool> isSelected;

  ModelPreferenci({
    required this.id,
    required this.title,
    required this.isSelected,
  });
}