import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../local/locator.dart';
import '../model/configs/fixtures.dart';
import '../view_model/tabresult_view_model.dart';

class TabResultWidget extends LocalRootWidget<TabResultViewModel> {
  Fixtures? fixtures;

  TabResultWidget({
    required this.fixtures,
    super.key,
  }) : super(getIt()) {
    model.setresult(fixtures);
  }

  @override
  Widget widget(TabResultViewModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Obx(() {
          if (model.categorizedResults.isEmpty) {
            return Center(
              child: Text(
                'No hay partidos en estos momentos',
                style: TextStyle(fontSize: 16.dp, color: Colors.white),
              ),
            );
          }
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.dp),
            child: ListView.separated(
              itemCount: model.categorizedResults.length,
              itemBuilder: (context, index) {
                var category = model.categorizedResults[index];
                var leagueName = category['eventdate'];
                var formattedDate = model.formatDateString(leagueName);
                var results = category['results'] as List<Fixtures>;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.dp)),
                    color: const Color(0xFF1D1E20),
                  ),
                  padding: EdgeInsets.all(10.dp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        formattedDate.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14.dp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Línea divisoria entre categorías
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: results.length,
                        itemBuilder: (context, idx) {
                          Fixtures result = results[idx];
                          return InkWell(
                            onTap: () => model.inforesult(result),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      result.stageName ?? "Pendiente",
                                      style: TextStyle(
                                          fontSize: 12.dp, color: Colors.white),
                                    ),
                                    result.eventStatus == ""
                                        ? Text(
                                            result.eventTime ?? "Pendiente",
                                            style: TextStyle(
                                                fontSize: 12.dp,
                                                color: Colors.white),
                                          )
                                        : Text(
                                            result.eventStatus ?? "Pendiente",
                                            style: TextStyle(
                                                fontSize: 12.dp,
                                                color: Colors.white),
                                          )
                                  ],
                                ),
                                SizedBox(height: 10.dp),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Image.network(
                                            result.homeTeamLogo ??
                                                "lib/assets/png/sport.png",
                                            width: 30.dp,
                                            height: 30.dp,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
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
                                                    size: 50.dp,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          SizedBox(width: 5.dp),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              result.eventHomeTeam ?? "",
                                              style: TextStyle(
                                                  fontSize: 12.dp,
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 15.dp),
                                    Text(
                                      result.eventFtResult != ""
                                          ? result.eventFtResult.toString()
                                          : result.eventFinalResult.toString(),
                                      style: TextStyle(
                                          fontSize: 12.dp, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 15.dp),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              result.eventAwayTeam ?? "",
                                              style: TextStyle(
                                                  fontSize: 12.dp,
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          SizedBox(width: 5.dp),
                                          Image.network(
                                            result.awayTeamLogo ??
                                                "lib/assets/png/sport.png",
                                            width: 30.dp,
                                            height: 30.dp,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
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
                                                    size: 50.dp,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
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
      ),
      model: model,
      context: context,
    );
  }
}
