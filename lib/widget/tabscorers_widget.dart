import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../local/locator.dart';
import '../model/configs/fixtures.dart';
import '../model/configs/topscorers.dart';
import '../view_model/tabpositions_view_model.dart';
import '../view_model/tabscorers_view_model.dart';

class TabScorersWidget extends LocalRootWidget<TabScorersViewModel> {
  Fixtures? fixtures;
  TabScorersWidget({
    required this.fixtures,
    super.key,
  }) : super(getIt()) {
    model.setresult(fixtures);
  }

  @override
  Widget widget(TabScorersViewModel model, BuildContext context) {
    return withLoading(
      body: Container(
        child: Obx(() {
          if (model.topsscorers.isEmpty) {
            return Center(
              child: Text(
                'No hay partidos en estos momentos',
                style: TextStyle(fontSize: 16.dp, color: Colors.white),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.dp,
            ),
            child: Container(
              padding: EdgeInsets.all(10.dp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.dp)),
                color: const Color(0xFF1D1E20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5.dp,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Jugador',
                          style:
                              TextStyle(fontSize: 14.dp, color: Colors.white),
                          textAlign: TextAlign
                              .start, // Alinea el encabezado del jugador a la izquierda
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Equipo',
                          style:
                              TextStyle(fontSize: 14.dp, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'G',
                          style:
                              TextStyle(fontSize: 14.dp, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'A',
                          style:
                              TextStyle(fontSize: 14.dp, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'PG',
                          style:
                              TextStyle(fontSize: 14.dp, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Expanded(
                    child: ListView.separated(
                      itemCount: model.topsscorers.length,
                      itemBuilder: (context, index) {
                        TopsScorers result = model.topsscorers[index];
                        return Container(
                          child: Row(children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                result.playerName.toString(),
                                style: TextStyle(
                                    fontSize: 14.dp, color: Colors.white),
                                textAlign: TextAlign
                                    .start, // Alinea el nombre del jugador a la izquierda
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                result.teamName!.toUpperCase().substring(0, 3),
                                style: TextStyle(
                                    fontSize: 14.dp, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                result.goals.toString(),
                                style: TextStyle(
                                    fontSize: 14.dp, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                result.assists == null?
                                "0": result.assists.toString(),
                                style: TextStyle(
                                    fontSize: 14.dp, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                result.penaltyGoals.toString(),
                                style: TextStyle(
                                    fontSize: 14.dp, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      model: model,
      context: context,
    );
  }
}
