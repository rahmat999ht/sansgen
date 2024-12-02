import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sansgen/utils/ext_context.dart';

class FormValidate extends StatelessWidget {
  const FormValidate({
    Key? key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.validator,
    required this.obscureText,
    this.keyboardType,
    this.color,
    this.suffixIcon,
  }) : super(key: key);
  final String title;
  final String hint;
  final String icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final ColorFilter? color;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelLargeBold,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textInputAction: TextInputAction.done,
          validator: validator,
          cursorColor: context.colorScheme.surface,
          // onChanged: ,
          decoration: InputDecoration(
            alignLabelWithHint: false,
            hintText: hint,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SvgPicture.asset(
                icon,
                colorFilter: color,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
