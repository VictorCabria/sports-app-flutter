import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../local/locator.dart';
import '../model/configs/fixtures.dart';
import '../view_model/tabheadtohead_view_model.dart';
import '../view_model/tablineups_view_model.dart';

class TabHeadToHeadWidget extends LocalRootWidget<TabHeadToHeadViewModel> {
  Fixtures? fixtures;
  TabHeadToHeadWidget({
    required this.fixtures,
    super.key,
  }) : super(getIt()) {
    model.setresult(fixtures);
  }

  @override
  Widget widget(TabHeadToHeadViewModel model, BuildContext context) {
    return withLoading(
      body: Container(
        child: Obx(
          () {
            if (model.h2hdetails.isEmpty) {
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
                child: ListView.builder(
                  itemCount: model.h2hdetails.length,
                  itemBuilder: (context, index) {
                    var h2hDetail = model.h2hdetails[index];
                    // Aquí puedes personalizar la vista de cada partido
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.dp)),
                        color: const Color(0xFF1D1E20),
                      ),
                      child: ListTile(
                        title: Text(
                          '${h2hDetail.h2h!.first.leagueName}',
                          style:
                              TextStyle(fontSize: 14.dp, color: Colors.white),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: h2hDetail.h2h!.map((match) {
                            return InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      match.eventStatus == ""
                                          ? Text(
                                              match.eventTime ?? "Pendiente",
                                              style: TextStyle(
                                                  fontSize: 12.dp,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              match.eventStatus ?? "Pendiente",
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
                                              match.homeTeamLogo ??
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
                                              errorBuilder:
                                                  (BuildContext context,
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
                                                match.eventHomeTeam ?? "",
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
                                        match.eventFinalResult.toString(),
                                        style: TextStyle(
                                            fontSize: 12.dp,
                                            color: Colors.white),
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
                                                match.eventAwayTeam ?? "",
                                                style: TextStyle(
                                                    fontSize: 12.dp,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                            SizedBox(width: 5.dp),
                                            Image.network(
                                              match.awayTeamLogo ??
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
                                              errorBuilder:
                                                  (BuildContext context,
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
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
      model: model,
      context: context,
    );
  }
}
