import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:sansgen/utils/ext_context.dart';
import '../../../../../keys/assets_icons.dart';
import '../../../../../widgets/form_validate.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

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
                  'Masuk',
                  style: context.titleLargeBold,
                ),
                const Gap(40),
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
                    obscureText: controller.isObscure.value,
                    suffixIcon: GestureDetector(
                      onTap: controller.stateObscure,
                      child: Icon(
                        !controller.isObscure.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 26,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const Gap(12),
                Align(
                  // heightFactor: 0.2,
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: controller.onTapLupaPass,
                    child: Text(
                      'Lupa Password?',
                      style: context.titleMediumBold,
                    ),
                  ),
                ),
                const Gap(40),
                ElevatedButton(
                  onPressed: controller.login,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Masuk'),
                ),
                const Gap(80),
                // const Text('Atau gunakan'),
                // const Gap(20),
                // InkWell(
                //   onTap: () {},
                //   child: SvgPicture.asset(
                //     KeysAssetsImages.google,
                //     width: 40,
                //     height: 40,
                //   ),
                // ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Belum memiliki akun? '),
                    InkWell(
                      onTap: controller.onTapSignUp,
                      child: Text('Sign Up', style: context.titleSmallBold),
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
