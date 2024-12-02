import 'package:flutter/material.dart';
import 'package:sansgen/utils/ext_context.dart';

class UpdateProfilFormValidate extends StatelessWidget {
  const UpdateProfilFormValidate({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.info,
    this.readOnly,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final String? info;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: controller,
          cursorColor: context.colorScheme.surface,
          readOnly: readOnly ?? false,
          // autocorrect : false,
          validator: (value) {
            if (nullValidation(value)) {
              return "Harap di isi";
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: context.colorScheme.primary,
            label: Text(
              hintText,
              style: context.titleMedium
                  .copyWith(color: context.colorScheme.surface),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
          ),
        ),
        // if (info != null)
        Visibility(
          visible: info != null,
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              info ?? "",
              style: context.formError,
            ),
          ),
        ),
      ],
    );
  }

  bool nullValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return true;
    }
    return false;
  }
}
