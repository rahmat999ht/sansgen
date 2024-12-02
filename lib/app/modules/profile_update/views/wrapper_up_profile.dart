import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/image.dart';
import '../controllers/image_profil_controller.dart';

class WrapperImageUpdateProfil extends GetView<ImageUpdateController>
    with ImageState {
  const WrapperImageUpdateProfil({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String? image;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => imageUpdateProfilSucces(
        state!,
        controller.getImage,
        context,
      ),
      onEmpty: imageUpdateProfilEmpty(
        image,
        controller.getImage,
        context,
      ),
    );
  }
}
