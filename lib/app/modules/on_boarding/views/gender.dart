import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/on_boarding_controller.dart';

class GenderView extends GetView<OnBoardingController> {
  const GenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.listGender.asMap().entries.map((entry) {
        int index = entry.key;
        var e = entry.value;
        return Obx(
          () => cardBorder(
            title: e.title,
            context: context,
            imageAssets: e.imageAssets,
            color: controller.selectedIndexGender.value == index &&
                    controller.selectedGender.value != ''
                ? context.colorScheme.surface
                : context.colorScheme.outline,
            index: index,
            onTap: () {
              controller.setGender(e.title);
              controller.selectedIndexGender.value = index;
            },
          ),
        );
      }).toList(),
    );
  }

  GestureDetector cardBorder({
    required BuildContext context,
    required String imageAssets,
    required String title,
    required Function() onTap,
    required Color color,
    required int index,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        width: 120,
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.onSecondary,
              offset: const Offset(12.0, 4.0),
              spreadRadius: 1.0,
              blurRadius: 2.0,
            ),
            BoxShadow(
              color: context.colorScheme.primary,
              offset: const Offset(12.0, 4.0),
              spreadRadius: -0.5,
              blurRadius: 2.0,
            ),
            BoxShadow(
              color: context.colorScheme.primary,
              offset: const Offset(0.0, 0.0),
              spreadRadius: -1.0,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imageAssets, width: 100, height: 100),
            Text(title, style: context.titleMedium),
          ],
        ),
      ),
    );
  }
}
