import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:deporte_app_flutter/widget/tabstatistics_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../local/locator.dart';
import '../view_model/player_soccer_view_model.dart';

class PlayerSoccerWidget extends LocalRootWidget<PlayerSoccerViewModel> {
  PlayerSoccerWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(PlayerSoccerViewModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: CustomAppBar(
          model: model,
        ),
        body: Obx(() {
          if (model.playerSoccer.isEmpty) {
            return Center(
              child: Text(
                'No hay informacion de este jugador',
                style: TextStyle(fontSize: 16.dp, color: Colors.white),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.all(5.0.dp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // Logo del equipo de fondo
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.2,
                        child: Image.network(
                          model.urlteams.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Contenedor principal con la imagen y la información del jugador
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0.dp),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: model.urlplayer.value != "",
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(model.urlplayer.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              constraints: BoxConstraints(
                                maxHeight: 180.dp,
                                maxWidth: 120.dp,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: model.urlplayer.value == "",
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "lib/assets/png/jugadoranonimo.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              constraints: BoxConstraints(
                                maxHeight: 180.dp,
                                maxWidth: 120.dp,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 22.dp, horizontal: 30.dp),
                              color: Colors.black.withOpacity(0.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.player!.player.toString(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8.dp),
                                  Row(
                                    children: [
                                      Image.network(
                                        model.urlteams.value,
                                        width: 24.dp,
                                        height: 24.dp,
                                      ),
                                      SizedBox(width: 8.dp),
                                      Text(
                                        '${model.awayresult.value}  #${model.playernumber.value}  A',
                                        style: TextStyle(
                                          fontSize: 18.dp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.dp),
                                  Text(
                                    'Nacionalidad: ${model.playercountry.value}',
                                    style: TextStyle(
                                        fontSize: 16.dp, color: Colors.white),
                                  ),
                                  Text(
                                    'Edad: ${model.edad.value} (${model.yearnacimiento.value})',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    "Posicion: ${model.playertype.value == "Forwards" ? "Delantero" : model.playertype.value == "Goalkeepers" ? "Arquero" : model.playertype.value == "Defenders" ? "Defensa" : model.playertype.value == "Midfielders" ? "MedioCampista" : ""}",
                                    // Cambia según el jugador
                                    style: TextStyle(
                                        fontSize: 16.dp, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.dp),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Column(
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
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'ESTADÍSTICAS DE TEMPORADA 2024-25 ${model.fixtures!.leagueName!.toUpperCase()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.dp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.dp),
                      StatisticsRow(
                          goals: model.playergoals.toString(),
                          assists: model.playerassists.toString(),
                          matchplayed: model.playermatchplayed.toString(),
                          substitutes: model.playersubstitutes.toString(),
                          rating: model.playerrating.value == "0"
                              ? model.playerrating.value
                              : "0"),
                      SizedBox(height: 10.dp),
                      Divider(thickness: 2.dp),
                    
                    ],
                    
                  ),
                ),
                TabStatisticsPlayerWidget(fixtures: model.player)
              ],
            ),
          );
        }),
      ),
      model: model,
      context: context,
    );
  }
}

class StatisticsRow extends StatelessWidget {
  final String goals;
  final String assists;
  final String matchplayed;
  final String substitutes;
  final String rating;

  const StatisticsRow(
      {super.key,
      required this.goals,
      required this.assists,
      required this.matchplayed,
      required this.substitutes,
      required this.rating});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatisticsColumn(
            title: 'TIT (SUP)', value: '${matchplayed} (${substitutes})'),
        StatisticsColumn(title: 'G', value: goals),
        StatisticsColumn(title: 'A', value: assists),
        StatisticsColumn(title: 'CJ', value: rating),
      ],
    );
  }
}

class StatisticsColumn extends StatelessWidget {
  final String title;
  final String value;

  const StatisticsColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.dp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.dp,
          ),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final PlayerSoccerViewModel model;

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
        model.player!.player.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0.dp,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        color: Colors.white,
        iconSize: 30.dp,
        onPressed: () => model.getback(),
      ),
      centerTitle: true,
    );
  }
}
