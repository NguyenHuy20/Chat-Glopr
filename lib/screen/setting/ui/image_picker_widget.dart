import 'dart:io';

import 'package:chat_glopr/@share/applicationmodel/profile/profile_bloc.dart';
import 'package:chat_glopr/@share/values/colors.dart';
import 'package:chat_glopr/screen/setting/view_model/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../@share/values/styles.dart';
import '../../../@share/widgets/imagepicker/image_picker_handler.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget(
      {super.key, required this.settingBloc, required this.profileBloc});
  final SettingBloc settingBloc;
  final ProfileBloc profileBloc;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget>
    with TickerProviderStateMixin, ImagePickerListener {
  late ImagePickerHandler imagePicker;
  late AnimationController _controller;
  File? localImage;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = ImagePickerHandler(this, _controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 70),
            // height: getHeight(context) - getHeight(context) / 15,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Change avatar',
                          style: titleStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Remove avatar',
                          style: titleStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        imagePicker.openCamera();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(17),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(width: 5, color: pink)),
                        child: Image.asset('assets/icons/camera.webp'),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        imagePicker.openGallery();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(17),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(width: 5, color: pink)),
                        child: Image.asset('assets/icons/image.webp'),
                      ),
                    )
                  ],
                )
              ],
            )),
      ],
    );
  }

  @override
  userImage(File image) async {
    widget.settingBloc.add(UploadImageEvent(
        context: context,
        file: image,
        profileData: widget.profileBloc.profileDataModel!));
  }
}
