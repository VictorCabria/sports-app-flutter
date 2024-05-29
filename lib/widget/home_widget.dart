import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';

import '../di/locator.dart';
import '../view_model/home_view_model.dart';

class HomeWidget extends LocalRootWidget<NewHomeViewModel> {
  HomeWidget() : super(getIt());

  @override
  Widget widget(NewHomeViewModel model, BuildContext context) {
    return withLoading(body: Container(), model: model, context: context);
  }
}
