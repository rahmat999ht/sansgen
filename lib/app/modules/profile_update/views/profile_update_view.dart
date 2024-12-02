import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/app/routes/app_pages.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/update_profil_form_validate.dart';

import '../controllers/profile_update_controller.dart';
import 'wrapper_up_profile.dart';

class ProfileUpdateView extends GetView<ProfileUpdateController> {
  const ProfileUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return; // Jika sudah di-pop, tidak perlu tindakan lagi
        final onPop = await controller.onWillPop(context);
        if (onPop) {
          Get.offAllNamed(Routes.DASHBOARD, arguments: 3);
        } else {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: appBarProUpdate(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  // gradient: LinearGradient(
                  //   colors: [
                  //     context.colorScheme.onSecondaryContainer,
                  //     context.colorScheme.primaryContainer
                  //   ],
                  //   stops: const [0.0, 1.0],
                  //   begin: Alignment.topLeft,
                  //   // end: Alignment.bottomRight,
                  // ),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(12),
                    Text('Siapkan Profil Anda',
                        style: context.titleLarge
                            .copyWith(color: context.colorScheme.primary)),
                    const Gap(20),
                    WrapperImageUpdateProfil(
                      image: controller.user.image,
                    ),
                    const Gap(50)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Pribadi',
                        style: context.titleMediumBold
                            .copyWith(color: context.colorScheme.onPrimary),
                      ),
                      const Gap(20),
                      UpdateProfilFormValidate(
                        hintText: 'Nama Lengkap',
                        controller: controller.nameController,
                        info: controller.isNameMessage.value,
                      ),
                      UpdateProfilFormValidate(
                        hintText: 'Hobby',
                        controller: controller.hobbyController,
                        info: controller.isjkelMessage.value,
                      ),
                      GestureDetector(
                        onTap: () => controller.datePick(context: context),
                        child: AbsorbPointer(
                          child: UpdateProfilFormValidate(
                            hintText: 'Tanggal Lahir',
                            controller: controller.tglLahirController,
                            info: controller.istglLahirMessage.value,
                            readOnly: true,
                          ),
                        ),
                      ),
                      const Gap(20),
                      ElevatedButton(
                        onPressed: controller.profilUpdateButton,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Simpan',
                          style: context.titleMedium
                              .copyWith(color: context.colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // resizeToAvoidBottomInset: false,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 32),
        //   child:
        // ),
      ),
    );
  }

  AppBar appBarProUpdate(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          controller.onWillPop(context).then((e) {
            if (e) {
              Get.offAllNamed(Routes.DASHBOARD, arguments: 3);
            }
          });
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: context.colorScheme.primary,
        ),
      ),
      backgroundColor: context.colorScheme.surface,
      // flexibleSpace:
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Text(
            'Edit Profile',
            style: context.titleLargeBold
                .copyWith(color: context.colorScheme.primary),
          ),
        ],
      ),
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(280),
      //   child:
      // ),
    );
  }
}
