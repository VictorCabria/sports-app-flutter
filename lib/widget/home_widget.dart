import 'package:deporte_app_flutter/local/locator.dart';
import 'package:deporte_app_flutter/widget/leagues_widget.dart';
import 'package:deporte_app_flutter/widget/results_widget.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:deporte_app_flutter/widget/user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../view_model/home_view_model.dart';

class HomeWidget extends LocalRootWidget<NewHomeViewModel> {
  HomeWidget() : super(getIt());

  @override
  Widget widget(NewHomeViewModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        body: Obx(
          () {
            // Verificar que selectedIndex tiene un valor válido
            int selectedIndex = model.selectedIndex.value;
            if (selectedIndex < 0 || selectedIndex >= 3) {
              selectedIndex =
                  0; // Valor predeterminado en caso de valor inválido
            }
            return IndexedStack(
              index: selectedIndex,
              children: [
                LeaguesWidget(),
                ResultsWidget(),
                UserProfileWidget(),
              ],
            );
          },
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.dp, vertical: 10.dp),
          child: Obx(() {
            // Verificar que selectedIndex tiene un valor válido
            int selectedIndex = model.selectedIndex.value;
            if (selectedIndex < 0 || selectedIndex >= 3) {
              selectedIndex =
                  0; // Valor predeterminado en caso de valor inválido
            }
            return GNav(
              gap: 8,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              selectedIndex: selectedIndex,
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
            );
          }),
        ),
      ),
      model: model,
      context: context,
    );
  }
}
