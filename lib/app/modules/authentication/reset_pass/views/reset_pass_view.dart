import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../../keys/assets_icons.dart';
import '../../../../../widgets/form_validate.dart';
import '../controllers/reset_pass_controller.dart';

class ResetPassView extends GetView<ResetPassController> {
  const ResetPassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Gap(60),
            Text(
              'Lupa password',
              style: context.titleLargeBold,
            ),
            const Gap(100),
            FormValidate(
              title: 'Password',
              hint: 'Masukan password',
              icon: KeysAssetsIcons.pass,
              controller: controller.passwordController,
              validator: (v) {
                return null;
              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: false,
            ),
            FormValidate(
              title: 'Confirm password',
              hint: 'Masukan kembali password',
              icon: KeysAssetsIcons.pass,
              controller: controller.komfirPassController,
              validator: (v) {
                return null;
              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: false,
            ),
            const Gap(40),
            ElevatedButton(
              onPressed: controller.resetPass,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Kirim'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
