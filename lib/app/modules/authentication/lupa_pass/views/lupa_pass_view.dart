import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../../keys/assets_icons.dart';
import '../../../../../widgets/form_validate.dart';
import '../controllers/lupa_pass_controller.dart';

class LupaPassView extends GetView<LupaPassController> {
  const LupaPassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const Gap(60),
                Text(
                  'Lupa password',
                  style: context.titleLargeBold,
                ),
                const Gap(100),
                FormValidate(
                  title: 'Email',
                  hint: 'Masukan email',
                  icon: KeysAssetsIcons.email,
                  controller: controller.emailController,
                  validator: (v) => controller.validateEmail(v),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                ),
                const Gap(40),
                ElevatedButton(
                  onPressed: controller.kirimEmail,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Kirim'),
                ),
                Gap(Get.height * 0.15),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Kembali ke halaman '),
                    InkWell(
                      onTap: controller.backToLogin,
                      child: Text('Sign In', style: context.titleSmallBold),
                    ),
                  ],
                ),
                const Gap(60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
