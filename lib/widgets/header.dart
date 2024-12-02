import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sansgen/utils/ext_context.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    this.height,
  }) : super(key: key);

  final double? height;

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (context, mode) {
        Widget body;
        body = CupertinoActivityIndicator(color: context.colorScheme.surface);
        return SizedBox(
          height: height ?? 20.0,
          child: Center(child: body),
        );
      },
    );
  }
}
