import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../state/empty.dart';
import '../../../../state/error.dart';
import '../../../../state/loading.dart';
import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
                controller.listPage[controller.currentPage.value].titleAppBar),
          ),
          centerTitle: true,
          backgroundColor: context.colorScheme.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.listPage[controller.currentPage.value].title,
                  style: context.titleMedium,
                ),
                const Gap(32),
                controller.listPage[controller.currentPage.value].page,
                SizedBox(width: Get.width),
              ],
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40, right: 20, left: 20),
          child: ElevatedButton(
            onPressed: controller.nextPage,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              controller.listPage[controller.currentPage.value].titleButton,
            ),
          ),
        ),
      ),
      onLoading: const LoadingState(),
      onError: (error) => ErrorState(error: error.toString()),
      onEmpty: const EmptyState(),
    );
  }
}
