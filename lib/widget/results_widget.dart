import 'package:deporte_app_flutter/widget/image_show_widget.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../local/locator.dart';
import '../model/configs/live_result.dart';
import '../view_model/results_view_model.dart';
import '../view_model/user_profile_view_model.dart';

class ResultsWidget extends LocalRootWidget<ResultsModel> {
  ResultsWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(ResultsModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: CustomAppBar(model: model),
        body: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: ListView.separated(
              itemCount: model.categorizedResults.length,
              itemBuilder: (context, index) {
                var category = model.categorizedResults[index];
                var leagueName = category['leagueName'];
                var results = category['results'] as List<Resultlive>;
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
                              leagueName ?? "Competencia",
                              style: TextStyle(
                                  fontSize: 16.dp, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Ver todo',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Línea divisoria entre categorías
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: results.length,
                        itemBuilder: (context, idx) {
                          Resultlive result = results[idx];
                          return Column(
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
                                    Text(
                                      result.eventTime ?? "Pendiente",
                                      style: TextStyle(
                                          fontSize: 12.dp, color: Colors.white),
                                    ),
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
                                      result.eventHalftimeResult ?? "0 - 0",
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
                              ]);
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

            /* ListView.separated(
              itemCount: model.liveresult.length,
              itemBuilder: (context, index) {
                return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.dp)),
                      color: const Color(0xFF1D1E20),
                    ),
                    padding: EdgeInsets.all(10.dp),
                    height: 165.dp,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  model.liveresult[index].leagueName ??
                                      "Competencia",
                                  style: TextStyle(
                                      fontSize: 16.dp, color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Ver todo',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                model.liveresult[index].stageName ??
                                    "Pendiente",
                                style: TextStyle(
                                    fontSize: 12.dp, color: Colors.white),
                              ),
                              Text(
                                model.liveresult[index].eventTime ??
                                    "Pendiente",
                                style: TextStyle(
                                    fontSize: 12.dp, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.dp),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "lib/assets/png/barcelona.png",
                                    width: 30.dp,
                                    height: 30.dp,
                                  ),
                                  SizedBox(width: 5.dp),
                                  Text(
                                    "Barcelona",
                                    style: TextStyle(
                                        fontSize: 12.dp, color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                "VS",
                                style: TextStyle(
                                    fontSize: 12.dp, color: Colors.white),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Real Madrid",
                                    style: TextStyle(
                                        fontSize: 12.dp, color: Colors.white),
                                  ),
                                  SizedBox(width: 5.dp),
                                  Image.asset(
                                    "lib/assets/png/barcelona.png",
                                    width: 30.dp,
                                    height: 30.dp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.network(
                                      model.liveresult[index].homeTeamLogo ??
                                          "lib/assets/png/sport.png",
                                      width: 30.dp,
                                      height: 30.dp,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
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
                                              size: 50.dp,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    SizedBox(width: 5.dp),
                                    Expanded(
                                      child: Text(
                                        model.liveresult[index].eventHomeTeam ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 12.dp,
                                            color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                model.liveresult[index].eventHalftimeResult ??
                                    "0 - 0",
                                style: TextStyle(
                                    fontSize: 12.dp, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        model.liveresult[index].eventAwayTeam ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 12.dp,
                                            color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    SizedBox(width: 5.dp),
                                    Image.network(
                                      model.liveresult[index].awayTeamLogo ??
                                          "lib/assets/png/sport.png",
                                      width: 30.dp,
                                      height: 30.dp,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
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
                        ]));
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.transparent,
              ),
            ), */
          ),
        ),
      ),
      model: model,
      context: context,
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final ResultsModel model;

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
        'Resultados',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0.dp,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          iconSize: 30.dp,
          onPressed: () {},
        ),
        SizedBox(width: 16.dp),
      ],
    );
  }
}
