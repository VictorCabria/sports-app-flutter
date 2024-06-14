import 'package:deporte_app_flutter/widget/image_show_widget.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../local/locator.dart';
import '../view_model/leagues_view_model.dart';

class LeaguesWidget extends LocalRootWidget<NewLeaguesWidgetViewModel> {
  LeaguesWidget() : super(getIt());

  @override
  Widget widget(NewLeaguesWidgetViewModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        backgroundColor: Color(0xFF121212),
        appBar: CustomAppBar(model: model),
        body: Obx(() => Container(
              padding: EdgeInsets.symmetric(horizontal: 5.dp, vertical: 5.dp),
              child: ListView.separated(
                itemCount: model.leagues.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.dp)),
                      color: Color(0xFF1D1E20),
                    ),
                    padding: EdgeInsets.all(10.dp),
                    height: 280.dp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              model.leagues[index].leagueLogo ??
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
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.transparent,
                ),
              ),
            )),
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
