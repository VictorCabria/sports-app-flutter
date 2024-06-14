import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';

import '../local/locator.dart';
import '../view_model/results_view_model.dart';
import '../view_model/user_profile_view_model.dart';

class ScorersWidget extends LocalRootWidget<ResultsModel> {
  ScorersWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(ResultsModel model, BuildContext context) {
    return withLoading(
        body: Scaffold(
          body: Text("pagina 3"),
        ),
        model: model,
        context: context);
  }
}
