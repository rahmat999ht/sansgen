import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../../keys/assets_icons.dart';
import '../../../../../widgets/form_validate.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: controller.formKey,
            // autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                const Gap(40),
                Text(
                  'Daftar',
                  style: context.titleLargeBold,
                ),
                const Gap(40),
                FormValidate(
                  title: 'Nama',
                  hint: 'Masukan nama',
                  icon: KeysAssetsIcons.user,
                  controller: controller.nameController,
                  validator: (v) => controller.validateName(v),
                  keyboardType: TextInputType.name,
                  color: ColorFilter.mode(
                    context.colorScheme.onPrimary.withOpacity(0.7),
                    BlendMode.srcIn,
                  ),
                  obscureText: false,
                ),
                const Gap(20),
                FormValidate(
                  title: 'Email',
                  hint: 'Masukan email',
                  icon: KeysAssetsIcons.email,
                  controller: controller.emailController,
                  validator: (v) => controller.validateEmail(v),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                ),
                const Gap(20),
                Obx(
                  () => FormValidate(
                    title: 'Password',
                    hint: 'Masukan password',
                    icon: KeysAssetsIcons.pass,
                    controller: controller.passwordController,
                    validator: (v) => controller.validatePassword(v),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.isObscurePass.value,
                    suffixIcon: GestureDetector(
                      onTap: controller.stateObscurePass,
                      child: Icon(
                        !controller.isObscurePass.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 26,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const Gap(20),
                Obx(
                  () => FormValidate(
                    title: 'Confirm password',
                    hint: 'Masukan kembali password',
                    icon: KeysAssetsIcons.pass,
                    controller: controller.komfirPassController,
                    validator: (v) => controller.validateConfirmPassword(v),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.isObscureComPass.value,
                    suffixIcon: GestureDetector(
                      onTap: controller.stateObscureComPass,
                      child: Icon(
                        !controller.isObscureComPass.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 26,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const Gap(20),
                ElevatedButton(
                  onPressed: controller.register,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Daftar'),
                ),
                const Gap(20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Sudah memiliki akun? '),
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
