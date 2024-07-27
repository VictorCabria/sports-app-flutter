import 'package:deporte_app_flutter/model/configs/player_soccer.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../local/locator.dart';
import '../model/configs/fixtures.dart';
import '../model/configs/standing.dart';
import '../view_model/tabpositions_view_model.dart';
import '../view_model/tabresult_view_model.dart';
import '../view_model/tabstatistics_player_view_model.dart';

class TabStatisticsPlayerWidget
    extends LocalRootWidget<TabStatisticsPlayerViewModel> {
  Player? fixtures;
  TabStatisticsPlayerWidget({
    required this.fixtures,
    super.key,
  }) : super(getIt()) {
    model.setresult(fixtures);
  }

  @override
  Widget widget(TabStatisticsPlayerViewModel model, BuildContext context) {
    return withLoading(
      body: Obx(() {
        if (model.playerSoccer.isEmpty) {
          return Center(
            child: Text(
              'No hay partidos en estos momentos',
              style: TextStyle(fontSize: 16.dp, color: Colors.white),
            ),
          );
        }
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
                      "Competencia",
                      style: TextStyle(fontSize: 16.dp, color: Colors.white),
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
                      style: TextStyle(fontSize: 14.dp, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Temporada',
                      style: TextStyle(fontSize: 14.dp, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'TT',
                      style: TextStyle(fontSize: 14.dp, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'G',
                      style: TextStyle(fontSize: 14.dp, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'A',
                      style: TextStyle(fontSize: 14.dp, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'TA',
                      style: TextStyle(fontSize: 14.dp, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'TR',
                      style: TextStyle(fontSize: 14.dp, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.playerSoccer.length,
                itemBuilder: (context, idx) {
                  PlayerSoccer result = model.playerSoccer[idx];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4.dp),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "",
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Image.network(
                            "",
                            width: 20.dp,
                            height: 20.dp,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
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
                            "",
                            style: TextStyle(
                                fontSize: 14.dp, color: Colors.blue[300]),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "",
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "",
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "",
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "",
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "",
                            style:
                                TextStyle(fontSize: 14.dp, color: Colors.grey),
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
      }),
      model: model,
      context: context,
    );
  }
}
