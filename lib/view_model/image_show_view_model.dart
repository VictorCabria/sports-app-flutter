import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'root_view_model.dart';

class ImageShowViewModel extends RootViewModel {
  ImageShowViewModel() : super(null) {
    initialize();
  }

  RxString _image = ''.obs;
  Rx<double?> _width = Rx<double?>(null);
  Rx<double?> _height = Rx<double?>(null);
  RxBool _isAsset = false.obs;
  Rx<Color?> _color = Rx<Color?>(null);

  String get image => _image.value;
  double? get width => _width.value;
  double? get height => _height.value;
  bool get isAsset => _isAsset.value;
  Color? get color => _color.value;

  set image(String value) {
    _image.value = value;
  }

  set width(double? value) {
    _width = value.obs;
  }

  set height(double? value) {
    _height = value.obs;
  }

  set isAsset(bool value) {
    _isAsset.value = value;
  }

  set color(Color? value) {
    _color.value = value;
  }

  bool isPng() {
    return _image.value.contains('.png');
  }

  @override
  initialize() async {}
}
