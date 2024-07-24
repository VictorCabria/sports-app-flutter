import 'package:deporte_app_flutter/widget/root_widget.dart';
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
        body: Padding(
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
                  Obx(
                    () => Container(
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
                                  image: NetworkImage(model.urlplayer.toString()),
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
                                  image:
                                      AssetImage("lib/assets/png/jugadoranonimo.png"),
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
                  )
                ],
              ),
              SizedBox(height: 16.dp),
              Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ESTADÍSTICAS DE TEMPORADA 2024 MLS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn('TIT (SUP)', '11 (1)'),
                        _buildStatColumn('G', '12'),
                        _buildStatColumn('A', '13'),
                        _buildStatColumn('TT', '58'),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              BottomNavigationBar(
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Perfil de Jugador',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.article),
                    label: 'Bio',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.fiber_new),
                    label: 'Noticias',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: 'Partidos',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart),
                    label: 'Estadísticas',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      model: model,
      context: context,
    );
  }

  Column _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.white),
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
