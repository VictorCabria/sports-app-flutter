import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../local/locator.dart';
import '../model/configs/fixtures.dart';
import '../model/configs/standing.dart';
import '../view_model/tabpositions_view_model.dart';
import '../view_model/tabresult_view_model.dart';

class TabPositionsWidget extends LocalRootWidget<TabPositionsViewModel> {
  Fixtures? fixtures;
  TabPositionsWidget({
    required this.fixtures,
    super.key,
  }) : super(getIt()) {
    model.setresult(fixtures);
  }

  @override
  Widget widget(TabPositionsViewModel model, BuildContext context) {
    return withLoading(
      body: Obx(() {
        if (model.categorizedtabpositions.isEmpty) {
          return Center(
            child: Text(
              'No hay partidos en estos momentos',
              style: TextStyle(fontSize: 16.dp, color: Colors.white),
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.dp),
          child: ListView.separated(
            itemCount: model.categorizedtabpositions.length,
            itemBuilder: (context, index) {
              var category = model.categorizedtabpositions[index];
              var leagueRound = category['leagueRound'];
              var results = category['results'] as List<Standing>;
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.dp)),
                  color: const Color(0xFF1D1E20),
                ),
                padding: EdgeInsets.all(10.dp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            leagueRound ?? "Competencia",
                            style:
                                TextStyle(fontSize: 16.dp, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.dp),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '#',
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Equipo',
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'J',
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
                            'E',
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'P',
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'GF',
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'GC',
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'DIF',
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'PTS',
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: results.length,
                      itemBuilder: (context, idx) {
                        Standing result = results[idx];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4.dp),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  result.standingPlace.toString(),
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Image.network(
                                  result.teamlogo ?? "lib/assets/png/sport.png",
                                  width: 20.dp,
                                  height: 20.dp,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Column(
                                      children: [
                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 20.dp,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  result.standingTeam!
                                      .toUpperCase()
                                      .substring(0, 3),
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.blue[300]),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  result.standingP.toString(),
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  result.standingW.toString(),
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  result.standingD.toString(),
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  result.standingL.toString(),
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  result.standingF.toString(),
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  result.standingA.toString(),
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  result.standingGD.toString(),
                                  style: TextStyle(
                                    fontSize: 14.dp,
                                    color: result.standingGD! < 0
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  result.standingPTS.toString(),
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              color: Colors.transparent,
            ),
          ),
        );
      }),
      model: model,
      context: context,
    );
  }
}
