import 'package:deporte_app_flutter/widget/tablineups_widger.dart';
import 'package:deporte_app_flutter/widget/tabstatistics_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:get/get.dart';
import '../local/locator.dart';
import '../view_model/info_result_view_model.dart';

class InfoResultWidget extends LocalRootWidget<NewInforesultModel> {
  InfoResultWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(NewInforesultModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: CustomAppBar(model: model),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                model.resultlive!.leagueName ?? "Pendiente",
                style: TextStyle(fontSize: 12.dp, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10.dp),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.network(
                            model.resultlive!.homeTeamLogo ??
                                "lib/assets/png/sport.png",
                            width: 30.dp,
                            height: 30.dp,
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
                                    size: 30.sp,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 4.dp),
                        // Home team name
                        Text(
                          model.resultlive!.eventHomeTeam!
                              .substring(0, 3)
                              .toUpperCase(),
                          style:
                              TextStyle(fontSize: 16.dp, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(width: 30.dp),
                    Row(
                      children: [
                        Text(
                          model.homeresult.value,
                          style: TextStyle(
                              fontSize: 26.dp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 70.dp),
                        Text(
                          'F',
                          style:
                              TextStyle(fontSize: 16.dp, color: Colors.white),
                        ),
                        SizedBox(width: 70.dp),
                        Text(
                          model.awayresult.value,
                          style: TextStyle(
                              fontSize: 26.dp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.network(
                            model.resultlive!.awayTeamLogo ??
                                "lib/assets/png/sport.png",
                            width: 30.dp,
                            height: 30.dp,
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
                                    size: 30.sp,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 4.dp),
                        Text(
                          model.resultlive!.eventAwayTeam!
                              .substring(0, 3)
                              .toUpperCase(),
                          style:
                              TextStyle(fontSize: 16.dp, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white, height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Goles del equipo local
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: model.homeGoals.map((goal) {
                          return Text(
                            '⚽ ${goal.homeScorer} - ${goal.time}\' ${goal.info == 'Penalty' ? "(P)" : ""} ',
                            style:
                                TextStyle(fontSize: 12.dp, color: Colors.white),
                          );
                        }).toList(),
                      )),
                  // Goles del equipo visitante
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: model.awayGoals.map((goal) {
                          return Text(
                            '${goal.time}\' - ${goal.awayScorer} ${goal.info == 'Penalty' ? "(P)" : ""} ⚽',
                            style:
                                TextStyle(fontSize: 12.dp, color: Colors.white),
                          );
                        }).toList(),
                      )),
                ],
              ),
              const Divider(color: Colors.white, height: 20),
              /*  const Text(
                'Informacion del Partido',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ), */
              Container(
                // Expandir el espacio vertical restante
                child: Expanded(
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
                              Tab(
                                text: "Estadisticas",
                              ),
                              Tab(
                                text: "Alineaciones",
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: TabBarView(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: TabStatisticsWidget(
                                    fixtures: model.resultlive,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: TablineUpsWidget(),
                                ),
                              ],
                            ),
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
      ),
      model: model,
      context: context,
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final NewInforesultModel model;

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
        '${model.resultlive?.eventHomeTeam!.substring(0, 3).toUpperCase()}  vs  ${model.resultlive?.eventAwayTeam!.substring(0, 3).toUpperCase()}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0.dp,
        ),
      ),
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          color: Colors.white,
          iconSize: 30.dp,
          onPressed: () => model.getback()),
      centerTitle: true,
    );
  }
}
