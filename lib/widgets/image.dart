import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/avatar_widget.dart';

mixin ImageState {
  // TextButton imageEmpty(dynamic getImg) {
  //   return TextButton(
  //     onPressed: () async => await getImg(),
  //     child: const Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Icon(
  //           Icons.photo_camera,
  //           size: 20,
  //         ),
  //         SizedBox(
  //           width: 5,
  //         ),
  //         Text(
  //           'Tambahkan Nota',
  //           style: TextStyle(fontSize: 12),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget imageUpdateProfilEmpty(String? image, dynamic getImage, BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        SizedBox(
          height: 140,
          width: 140,
          child: AvatarWidget(
            image: image,
            height: 140,
            width: 140,
            radius: 100,
          ),
        ),

      ],
    );
  }

  Widget imageUpdateProfilSucces(
      List<XFile> state, dynamic getImage, BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Image.file(
            File(state.first.path),
            fit: BoxFit.cover,
            height: 140,
            width: 140,
          ),
        ),
        InkWell(
          onTap: () async => await getImage(),
          child: CircleAvatar(
            backgroundColor: context.colorScheme.onSecondary,
            child: SvgPicture.asset(
              KeysAssetsIcons.camera,
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget imageSuccess(List<XFile> state, void Function(int) removeImage) {
    return Container(
      height: 108,
      width: double.infinity,
      // color: Colors.red,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        reverse: false,
        scrollDirection: Axis.horizontal,
        itemCount: state.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6, right: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(state[index].path),
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  removeImage(index);
                },
                child:  ClipOval(
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    color: context.colorScheme.primary,
                    child: Icon(
                      Icons.cancel,
                      color: context.colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 12,
          );
        },
      ),
    );
  }
}
