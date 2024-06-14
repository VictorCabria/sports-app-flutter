import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../local/locator.dart';
import '../view_model/user_profile_view_model.dart';

class UserProfileWidget extends LocalRootWidget<UserProfileModel> {
  UserProfileWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(UserProfileModel model, BuildContext context) {
    return withLoading(
        body: Scaffold(
          body: Text("pagina 4"),
        ),
        model: model,
        context: context);
  }
}
