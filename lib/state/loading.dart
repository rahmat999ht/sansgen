import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sansgen/utils/ext_context.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: context.colorScheme.surface,
        size: 40,
      ),
    );
  }
}
