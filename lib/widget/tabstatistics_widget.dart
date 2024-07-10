import 'package:deporte_app_flutter/model/configs/fixtures.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../local/locator.dart';
import '../view_model/tablineups_view_model.dart';
import '../view_model/tabstatistics_view_model.dart';

class TabStatisticsWidget extends LocalRootWidget<TabStatisticsViewModel> {
  Fixtures? fixtures;
  TabStatisticsWidget({
    required this.fixtures,
    super.key,
  }) : super(getIt()) {
    model.setresult(fixtures);
  }

  @override
  Widget widget(TabStatisticsViewModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0.dp),
            child: SingleChildScrollView(
              child: model.fixtures!.statistics!.isEmpty
                  ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.dp),
                    child: Text(
                      'No hay estadísticas aún',
                      style: TextStyle(color: Colors.white, fontSize: 16.dp),
                      textAlign: TextAlign.center,
                    ),
                  )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildStatisticsView(model),
                        const Divider(
                          color: Colors.white,
                        ),
                        _buildFlagsView(model),
                        const Divider(
                          color: Colors.white,
                        ),
                        _buildPossessionChart(model),
                        SizedBox(height: 40.dp),
                        const Divider(
                          color: Colors.white,
                        ),
                        _buildbuildStatistics(model),
                      ],
                    ),
            ),
          ),
        ),
      ),
      model: model,
      context: context,
    );
  }

  // Vista 1: Estadísticas del Partido
  Widget _buildStatisticsView(TabStatisticsViewModel model) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10.dp),
          Text(
            'Estadísticas del Partido',
            style: TextStyle(fontSize: 12.dp, color: Colors.white),
          ),
          SizedBox(height: 10.dp),
        ],
      ),
    );
  }

  // Vista 2: Banderas de los Equipos
  Widget _buildFlagsView(TabStatisticsViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Equipo local
        Row(
          children: [
            Image.network(
              model.fixtures!.homeTeamLogo ?? "lib/assets/png/sport.png",
              width: 30.dp,
              height: 30.dp,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
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
            SizedBox(width: 8.dp),
            Text(
              model.fixtures!.eventHomeTeam!.substring(0, 3).toUpperCase(),
              style: TextStyle(fontSize: 12.dp, color: Colors.white),
            ),
          ],
        ),
        Container(
          width: 1.dp,
          height: 20.dp,
          color: Colors.white,
        ),
        // Equipo visitante
        Row(
          children: [
            Text(
              model.fixtures!.eventAwayTeam!.substring(0, 3).toUpperCase(),
              style: TextStyle(fontSize: 12.dp, color: Colors.white),
            ),
            SizedBox(width: 8.dp),
            Image.network(
              model.fixtures!.awayTeamLogo ?? "lib/assets/png/sport.png",
              width: 30.dp,
              height: 30.dp,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
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
          ],
        ),
      ],
    );
  }

  // Vista 3: Resto del Contenido
  Widget _buildPossessionChart(TabStatisticsViewModel model) {
    return Column(
      children: [
        Text(
          'Posesión',
          style: TextStyle(fontSize: 16.dp, color: Colors.white),
        ),
        SizedBox(height: 40.dp),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto de porcentaje izquierdo
            Text(
              '${model.homepossession.value}%',
              style: TextStyle(
                  fontSize: 18.dp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 40.dp),
            Container(
              width: 50.dp,
              height: 50.dp,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      radius: 15.dp,
                      color: Colors.blue,
                      value: double.parse(model.homepossession.value),
                      title: '',
                    ),
                    PieChartSectionData(
                      radius: 15.dp,
                      color: Colors.red,
                      value: double.parse(model.awaypossession.value),
                      title: '',
                    ),
                  ],
                  centerSpaceRadius: 40.dp,
                  startDegreeOffset: 82.dp,
                ),
              ),
            ),
            SizedBox(width: 40.dp),

            Text(
              '${model.awaypossession.value}%',
              style: TextStyle(
                  fontSize: 18.dp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildbuildStatistics(TabStatisticsViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildStatRow('Tiros realizados', model.homecshots.value,
              model.awayshots.value),
          buildStatRow('Tiros a Puerta', model.homeshotsongoal.value,
              model.awayshotsongoal.value),
          buildStatRow('Faltas', model.homeFouls.value, model.awayFouls.value),
          buildStatRow('Tarjetas Amarrillas', model.homecards.value,
              model.awaycards.value),
          buildStatRow('Tarjetas Rojas', model.homecardsred.value,
              model.awaycardsred.value),
          buildStatRow('Tiros de Esquina', model.homecorners.value,
              model.awaycorners.value),
          buildStatRow(
              'Salvadas', model.homesaves.value, model.awaysaves.value),
        ],
      ),
    );
  }

  Widget buildStatRow(String title, String teamA, String teamB) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.dp),
      child: Row(
        children: [
          Text(
            teamA == "" ? "0" : teamA,
            style: TextStyle(fontSize: 16.dp, color: Colors.white),
          ),
          SizedBox(width: 10.dp),
          Expanded(
            child: Row(
              children: [
                Spacer(),
                Text(
                  title,
                  style: TextStyle(fontSize: 16.dp, color: Colors.white),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(width: 10.dp),
          Text(
            teamB == "" ? "0" : teamB,
            style: TextStyle(fontSize: 16.dp, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
