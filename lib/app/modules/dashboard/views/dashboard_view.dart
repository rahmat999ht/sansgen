import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.getCurrentIndex].page),
      bottomNavigationBar: Obx(
        () => bottomBarSnake(context),
      ),
    );
  }

  SnakeNavigationBar bottomBarSnake(BuildContext context) {
    return SnakeNavigationBar.color(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      currentIndex: controller.getCurrentIndex,
      snakeViewColor: context.colorScheme.surface,
      backgroundColor: context.colorScheme.primary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (value) {
        controller.setCurrentIndex(value);
      },
      items: controller.pages.map(
        (e) {
          return BottomNavigationBarItem(
            label: e.title,
            icon: SvgPicture.asset(
              e.icon,
              colorFilter: ColorFilter.mode(
                controller.getCurrentIndex == e.index
                    ? context.colorScheme.primary
                    : context.colorScheme.onSecondary,
                BlendMode.srcIn,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
