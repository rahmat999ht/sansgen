import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../keys/assets_images.dart';

Widget bookEmpty(
  String info, {
  double? height,
}) {
  return Column(
    children: [
      SvgPicture.asset(
        KeysAssetsImages.dataEmpty,
        height: height ?? 190,
      ),
      Text(info),
    ],
  );
}
