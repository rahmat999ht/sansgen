
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../keys/assets_icons.dart';

Padding inputComment({
  required String hint,
  required BuildContext context,
  required TextEditingController controller,
  required void Function() onTapSend,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Card(
      elevation: 4,
      child: TextFormField(
        cursorColor: context.colorScheme.onPrimary,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: context.colorScheme.primary,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              KeysAssetsIcons.user,
              height: 13,
              colorFilter: ColorFilter.mode(
                context.colorScheme.onSecondary,
                BlendMode.srcIn,
              ),
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: onTapSend,
              child: SvgPicture.asset(
                KeysAssetsIcons.send,
                height: 13,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.onSecondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}