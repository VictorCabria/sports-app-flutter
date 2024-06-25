import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';

import '../local/locator.dart';
import '../view_model/tablineups_view_model.dart';

class TablineUpsWidget extends LocalRootWidget<TabLineupsViewModel> {
  TablineUpsWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(TabLineupsViewModel model, BuildContext context) {
    return withLoading(
        body: Container(
          child: Text("prueba2"),
        ),
        model: model,
        context: context);
  }
}
