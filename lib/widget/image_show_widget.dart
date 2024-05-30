import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../di/locator.dart';
import '../view_model/image_show_view_model.dart';
import 'root_widget.dart';

class ImageShowWidget extends LocalRootWidget<ImageShowViewModel> {
  ImageShowWidget({
    required String image,
    double? width,
    double? height,
    bool isAsset = false,
    Color? color,
  }) : super(getIt()) {
    model.image = image;
    model.width = width;
    model.height = height;
    model.isAsset = isAsset;
    model.color = color;
  }

  @override
  Widget widget(ImageShowViewModel model, BuildContext context) {
    return Obx(() => model.isAsset
        ? model.isPng()
            ? Image.asset(
                model.image,
                width: model.width,
                height: model.height,
                fit: BoxFit.contain,
                color: model.color,
              )
            : SvgPicture.asset(
                model.image,
                width: model.width,
                height: model.height,
                fit: BoxFit.contain,
                color: model.color,
              )
        : model.isPng()
            ? Image.network(
                model.image,
                width: model.width,
                height: model.height,
                fit: BoxFit.contain,
                color: model.color,
              )
            : SvgPicture.network(
                model.image,
                width: model.width,
                height: model.height,
                fit: BoxFit.contain,
                color: model.color,
              ));
  }
}
