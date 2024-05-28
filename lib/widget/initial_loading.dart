import 'package:flutter/material.dart';

import '../../di/locator.dart';
import '../view_model/initial_loading_view_model.dart';
import 'root_widget.dart';

class InitialLoadingWidget extends LocalRootWidget<InitialLoadingViewModel> {
  InitialLoadingWidget() : super(getIt());

  @override
  Widget widget(InitialLoadingViewModel model, BuildContext context) {
    return withLoading(
      body: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      model: model,
      context: context,
    );
  }
}
