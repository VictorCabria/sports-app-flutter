import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
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
              const Text(
                '2024 Eurocopa, Fase de grupos',
                style: TextStyle(fontSize: 12, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Home team (local)
                  Column(
                    children: [
                      // Home team logo
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
                      ),
                      const SizedBox(height: 4),
                      // Home team name
                       Text(
                        model.resultlive!.eventHomeTeam!.substring(0,3).toUpperCase(),
                        style: TextStyle(fontSize: 16.dp, color: Colors.white),
                      ),
                    ],
                  ),
                   SizedBox(width: 30.dp),
                   Row(
                    children: [
                      Text(
                        '1',
                        style: TextStyle(fontSize: 20.dp, color: Colors.white),
                      ),
                      SizedBox(width: 70.dp),
                      Text(
                        'F',
                        style: TextStyle(fontSize: 20.dp, color: Colors.white),
                      ),
                      SizedBox(width: 70.dp), 
                      Text(
                        '1',
                        style: TextStyle(fontSize: 20.dp, color: Colors.white),
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
                      ),
                      const SizedBox(height: 4),
                      // Away team name
                       Text(
                        model.resultlive!.eventAwayTeam!.substring(0,3).toUpperCase(),
                        style: TextStyle(fontSize: 16.dp, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(color: Colors.white, height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '⚽ Luka Modric - 55\'',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(
                    'Mattia Zaccagni - 90\'+8\'⚽',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
              const Divider(color: Colors.white, height: 20),
              const Text(
                'Línea de tiempo de juego',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              // Aquí se puede agregar un widget para la línea de tiempo del juego
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
        '${model.resultlive?.eventHomeTeam} vs ${model.resultlive?.eventAwayTeam}',
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
