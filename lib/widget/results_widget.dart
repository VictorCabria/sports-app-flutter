import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';

import '../local/locator.dart';
import '../view_model/results_view_model.dart';
import '../view_model/user_profile_view_model.dart';

class ResultsWidget extends LocalRootWidget<ResultsModel> {
  ResultsWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(ResultsModel model, BuildContext context) {
    return withLoading(
        body: Scaffold(
          body: Text("pagina 2"),
        ),
        model: model,
        context: context);
  }
}