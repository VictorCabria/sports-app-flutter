import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import '../local/locator.dart';
import '../model/configs/livescore.dart';
import '../view_model/leagues_view_model.dart';
import 'root_widget.dart';
import 'image_show_widget.dart';

class LeaguesWidget extends LocalRootWidget<NewLeaguesWidgetViewModel> {
  LeaguesWidget() : super(getIt());

  @override
  Widget widget(NewLeaguesWidgetViewModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        backgroundColor: Color(0xFF121212),
        appBar: CustomAppBar(model: model),
        body: LayoutBuilder(builder: (context, constraints) {
          return Obx(
            () {
              if (model.categorizedResults.isEmpty) {
                return Center(
                  child: Text(
                    'No hay partidos en estos momentos',
                    style: TextStyle(fontSize: 16.dp, color: Colors.white),
                  ),
                );
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 5.dp, vertical: 5.dp),
                child: ListView.separated(
                  itemCount: model.categorizedResults.length,
                  itemBuilder: (context, index) {
                    var category = model.categorizedResults[index];
                    var results = category['results'] as List<LivesScore>;
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.dp)),
                        color: const Color(0xFF1D1E20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Línea divisoria entre categorías
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: results.length,
                            itemBuilder: (context, idx) {
                              LivesScore result = results[idx];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Colors.white, Colors.blue],
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.dp),
                                        topRight: Radius.circular(10.dp),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 30.dp),
                                              child: Text(
                                                result.eventHomeTeam.toString(),
                                                style: TextStyle(
                                                  fontSize: 16.dp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 30.dp),
                                              child: Text(
                                                result.eventAwayTeam.toString(),
                                                style: TextStyle(
                                                  fontSize: 16.dp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.dp),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.dp),
                                    child: Column(
                                      children: [
                                        SizedBox(width: 10.dp),
                                        Text(
                                          result.leagueName.toString(),
                                          style: TextStyle(
                                            fontSize: 12.dp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10.dp),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Image.network(
                                                    result.homeTeamLogo ??
                                                        "lib/assets/png/sport.png",
                                                    width:
                                                        constraints.maxWidth *
                                                            0.08,
                                                    height:
                                                        constraints.maxWidth *
                                                            0.08,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
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
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return Column(
                                                        children: [
                                                          Icon(
                                                            Icons.error,
                                                            color: Colors.red,
                                                            size: constraints
                                                                    .maxWidth *
                                                                0.1,
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        constraints.maxWidth *
                                                            0.02),
                                                Text(
                                                  result.eventHomeTeam!
                                                      .substring(0, 3)
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 16.dp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                width: constraints.maxWidth *
                                                    0.02),
                                            Row(
                                              children: [
                                                Text(
                                                  model.homeresult.toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        constraints.maxWidth *
                                                            0.07,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.15),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "En vivo",
                                                      style: TextStyle(
                                                        fontSize: 14.dp,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      result.eventStatus ==
                                                              "Finished"
                                                          ? "F"
                                                          : result.eventStatus ==
                                                                  "Break Time"
                                                              ? "B.T"
                                                              : result.eventStatus ==
                                                                      "After ET"
                                                                  ? "A.ET"
                                                                  : result.eventStatus ==
                                                                          "After Pen."
                                                                      ? "Pens"
                                                                      : result.eventStatus ==
                                                                              "Half Time"
                                                                          ? "E"
                                                                          : result.eventStatus != ""
                                                                              ? result.eventStatus.toString()
                                                                              : "VS",
                                                      style: TextStyle(
                                                        fontSize: 14.dp,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.15),
                                                Text(
                                                  model.homeresult.toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        constraints.maxWidth *
                                                            0.07,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                width: constraints.maxWidth *
                                                    0.015),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Image.network(
                                                    result.awayTeamLogo ??
                                                        "lib/assets/png/sport.png",
                                                    width:
                                                        constraints.maxWidth *
                                                            0.08,
                                                    height:
                                                        constraints.maxWidth *
                                                            0.08,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
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
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return Column(
                                                        children: [
                                                          Icon(
                                                            Icons.error,
                                                            color: Colors.red,
                                                            size: constraints
                                                                    .maxWidth *
                                                                0.08,
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        constraints.maxWidth *
                                                            0.02),
                                                Text(
                                                  result.eventAwayTeam!
                                                      .substring(0, 3)
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 16.dp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                ],
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
            },
          );
        }),
      ),
      model: model,
      context: context,
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final NewLeaguesWidgetViewModel model;

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
      title: Align(
        alignment: Alignment.centerLeft,
        child: ImageShowWidget(
          color: Colors.white,
          isAsset: true,
          image: 'lib/assets/png/2logo_2gether.png',
          width: 170.16.dp,
          height: 33.dp,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          iconSize: 30.dp,
          onPressed: () {},
        ),
        SizedBox(width: 16.dp),
      ],
    );
  }
}
     /* Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              model.leagues[index].leaguelogo ??
                                  "lib/assets/png/sport.png",
                              width: 40.dp,
                              height: 40.dp,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
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
                                  Object exception, StackTrace? stackTrace) {
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
                            SizedBox(width: 10.dp),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    model.leagues[index].leagueName.toString(),
                                    style: TextStyle(
                                        fontSize: 16.dp, color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    model.leagues[index].countryName.toString(),
                                    style: TextStyle(
                                        fontSize: 14.dp, color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
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
                        SizedBox(height: 10.dp),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0.dp),
                          child: SizedBox(
                            height: 200.dp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Image.asset(
                                    'lib/assets/png/TECNICOBARCA.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    color: Colors.grey[500],
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0.dp,
                                          vertical: 8.0.dp),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Título del artículo',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0.dp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.0.dp),
                                          Text(
                                            'Publicado por Victor Cabria',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0.dp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ), */