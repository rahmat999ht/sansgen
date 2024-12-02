import 'package:flutter/material.dart';

ElevatedButton updateBirthdayButton({required void Function()? onPressed}) {
  return ElevatedButton(
      onPressed: onPressed, child: const Icon(Icons.date_range));
}
