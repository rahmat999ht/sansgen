import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sansgen/utils/ext_context.dart';

GestureDetector cardPreference({
    required BuildContext context,
    required String title,
    required Function() onTap,
    required Color color,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        // width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorScheme.outline,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.onSecondary,
              offset: const Offset(12.0, 4.0),
              spreadRadius: 1.0,
              blurRadius: 2.0,
            ),
            BoxShadow(
              color: context.colorScheme.primary,
              offset: const Offset(12.0, 4.0),
              spreadRadius: -0.5,
              blurRadius: 2.0,
            ),
            BoxShadow(
              color: context.colorScheme.primary,
              offset: const Offset(0.0, 0.0),
              spreadRadius: -1.0,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Checkbox(
            //   value: isSelected,
            //   onChanged: (value) {
            //     isSelected = value ?? false;
            //   },
            // ),
            SizedBox(
              width: 12,
              height: 12,
              child: Card(
                color: color,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: context.colorScheme.outline,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            const Gap(12),
            Text(title),
          ],
        ),
      ),
    );
  }
  