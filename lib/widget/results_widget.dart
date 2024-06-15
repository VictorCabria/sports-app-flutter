import 'package:deporte_app_flutter/widget/image_show_widget.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../local/locator.dart';
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
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: ListView.separated(
            itemCount: model.matches.length,
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
                              "Fase de grupos",
                              style:
                                  TextStyle(fontSize: 12.dp, color: Colors.white),
                            ),
                            Text(
                              "HOY 5:00 PM",
                              style:
                                  TextStyle(fontSize: 12.dp, color: Colors.white),
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
                              "1 - 0",
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
                      ]));
            },
            separatorBuilder: (context, index) => const Divider(
              color: Colors.transparent,
            ),
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
