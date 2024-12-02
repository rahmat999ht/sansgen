import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sansgen/utils/ext_context.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("pull up load", style: context.labelLarge);
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator(color: context.colorScheme.surface);
          // body =  CircularProgressIndicator(color: context.colorScheme.surface);
        } else if (mode == LoadStatus.failed) {
          body = Text("Tidak Ada lagi Data", style: context.labelLarge);
        } else if (mode == LoadStatus.canLoading) {
          body = Text("release to load more", style: context.labelLarge);
        } else {
          body = Text("Tidak Ada lagi Data", style: context.labelLarge);
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
