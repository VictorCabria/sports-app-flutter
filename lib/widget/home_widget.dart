import 'package:deporte_app_flutter/local/locator.dart';
import 'package:deporte_app_flutter/widget/leagues_widget.dart';
import 'package:deporte_app_flutter/widget/results_widget.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:deporte_app_flutter/widget/user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../view_model/home_view_model.dart';

class HomeWidget extends LocalRootWidget<NewHomeViewModel> {
  HomeWidget() : super(getIt());

  @override
  Widget widget(NewHomeViewModel model, BuildContext context) {
    // TODO: implement widget
    return withLoading(
        body: Scaffold(
            body: Obx(
              () => IndexedStack(
                index: model.selectedIndex.value,
                children: [
                  LeaguesWidget(),
                  ResultsWidget(),
                  UserProfileWidget(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.dp),
                  topRight: Radius.circular(8.dp),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.dp, vertical: 10.dp),
              child: GNav(
                gap: 8,
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                selectedIndex: model.selectedIndex.value,
                onTabChange: model.changeIndex,
                tabBackgroundColor: Colors.grey.shade800,
                padding: EdgeInsets.all(16.dp),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Portada',
                  ),
                  GButton(
                    icon: Icons.thirty_fps_select_sharp,
                    text: 'Resultados',
                  ),
                  GButton(
                    icon: Icons.account_circle_rounded,
                    text: 'Profile',
                  ),
                ],
              ),
            )),
        model: model,
        context: context);
  }
}
