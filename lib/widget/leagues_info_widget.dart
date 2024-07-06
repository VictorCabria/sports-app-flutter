import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:deporte_app_flutter/widget/tabpositions_widget.dart';
import 'package:deporte_app_flutter/widget/tabresult_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../local/locator.dart';

import '../view_model/league_info_view_model.dart';

class LeaguesInfoWidget extends LocalRootWidget<NewLeaguesInfoWidgetViewModel> {
  LeaguesInfoWidget() : super(getIt());

  @override
  Widget widget(NewLeaguesInfoWidgetViewModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
          backgroundColor: const Color(0xFF121212),
          appBar: CustomAppBar(
            model: model,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              children: [
                SizedBox(height: 15.dp), // Espacio entre el AppBar y el TabBar
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35.dp,
                          child: TabBar(
                            splashFactory: NoSplash.splashFactory,
                            indicatorSize: TabBarIndicatorSize.tab,
                            unselectedLabelColor:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            labelColor: Colors.white,
                            indicatorColor: Colors.red,
                            labelStyle: Theme.of(context).textTheme.titleSmall,
                            tabs: const [
                              Tab(text: "Resultados"),
                              Tab(text: "Posiciones"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20.dp,
                            alignment: Alignment.center,
                            child: TabBarView(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: TabResultWidget(
                                    fixtures: model.fixtures,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: TabPositionsWidget(
                                    fixtures: model.fixtures,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
      model: model,
      context: context,
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final NewLeaguesInfoWidgetViewModel model;

  CustomAppBar({Key? key, required this.model})
      : preferredSize = Size.fromHeight(70.dp),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.dp),
          bottomRight: Radius.circular(8.dp),
        ),
      ),
      toolbarHeight: 109.dp,
      titleSpacing: 20.dp,
      title: Text(
        model.fixtures!.leagueName.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0.dp,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        iconSize: 30.dp,
        onPressed: () => model.getback(),
      ),
    );
  }
}
