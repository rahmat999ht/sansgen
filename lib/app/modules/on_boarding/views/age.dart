import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/on_boarding_controller.dart';

class AgeView extends GetView<OnBoardingController> {
  const AgeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.listAge.asMap().entries.map((entry) {
        int index = entry.key;
        var e = entry.value;
        return Obx(
          () => cardBorder(
            title: e,
            context: context,
            color: controller.selectedIndexAge.value == index &&
                    controller.selectedAge.value != ''
                ? context.colorScheme.surface
                : context.colorScheme.outline,
            index: index,
            onTap: () {
              controller.setAge(e);
              controller.selectedIndexAge.value = index;
            },
          ),
        );
      }).toList(),
    );
  }

  GestureDetector cardBorder({
    required BuildContext context,
    required String title,
    required Function() onTap,
    required Color color,
    required int index,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
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
        child: Center(child: Text(title)),
      ),
    );
  }
}
