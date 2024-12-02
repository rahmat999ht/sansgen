import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/card_preference.dart';

import '../controllers/on_boarding_controller.dart';

class PreferenciView extends GetView<OnBoardingController> {
  const PreferenciView({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 20.0,
      runSpacing: 20.0,
      children: controller.listPreferences.asMap().entries.map((entry) {
        int index = entry.key;
        var e = entry.value;
        return Obx(
          () => cardPreference(
            title: e.title,
            isSelected: e.isSelected.value,
            context: context,
            color: e.isSelected.value == true
                ? context.colorScheme.surface
                : context.colorScheme.primary,
            index: index,
            onTap: () => e.isSelected.value = !e.isSelected.value,
          ),
        );
      }).toList(),
    );
  }

  
}
