import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sansgen/keys/assets_images.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            KeysAssetsImages.serverError,
            width: 240,
          ),
          const Gap(20),
          const Text('Server down'),
        ],
      ),
    );
  }
}
