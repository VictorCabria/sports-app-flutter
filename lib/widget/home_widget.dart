import 'package:deporte_app_flutter/widget/image_show_widget.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../local/locator.dart';
import '../view_model/home_view_model.dart';

class HomeWidget extends LocalRootWidget<NewHomeViewModel> {
  HomeWidget() : super(getIt());

  @override
  Widget widget(NewHomeViewModel model, BuildContext context) {
    return withLoading(
        body: Scaffold(
            backgroundColor: Color.fromARGB(255, 20, 19, 19),
            appBar: CustomAppBar(model: model),
            body: Obx(() => Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.dp, vertical: 5.dp),
                  child: ListView.separated(
                    itemCount: model.leagues.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.dp)),
                          color: Color.fromARGB(221, 37, 36, 36),
                        ),
                        padding: EdgeInsets.all(10.dp),
                        height: 250
                            .dp, // Incrementa la altura para acomodar el nuevo Container
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
                                SizedBox(
                                    width: 10
                                        .dp), // Espacio entre la imagen y el texto
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.leagues[index].leagueName
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16.dp,
                                            color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        model.leagues[index].countryName
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14.dp,
                                            color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.dp),
                            Container(
                              height:
                                  165.dp, // Altura del nuevo Container verde
                              color: Colors.grey[500],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                    ),
                  ),
                )),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.dp),
                  topRight: Radius.circular(8.dp),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.dp, vertical: 10.dp),
              child: GNav(
                gap: 8,
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                selectedIndex: model.currentIndex,
                onTabChange: model.onMenuChanged,
                tabBackgroundColor: Colors.grey.shade800,
                padding: EdgeInsets.all(16.dp),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Portada',
                  ),
                  GButton(
                    icon: Icons.thirty_fps_select_sharp,
                    text: 'Resultados',
                  ),
                  GButton(
                    icon: Icons.account_box,
                    text: 'Goleadores',
                  ),
                  GButton(
                    icon: Icons.account_circle_rounded,
                    text: 'Profile',
                  ),
                ],
              ),
            )),
        model: model,
        context: context);
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final NewHomeViewModel model;

  CustomAppBar({Key? key, required this.model})
      : preferredSize =
            Size.fromHeight(70.dp), // Set here your preferred height for AppBar
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70.dp,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.dp),
            bottomRight: Radius.circular(8.dp),
          ),
        ),
        child: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: LayoutBuilder(builder: (context, constraints) {
            double thresholdWidth = 360.dp;
            double imageWidth = 213.16.dp;
            double imageHeight = 33.dp;

            if (constraints.maxWidth < thresholdWidth) {
              double factor = constraints.maxWidth / thresholdWidth;
              imageWidth *= factor;
              imageHeight *= factor;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: ImageShowWidget(
                    isAsset: true,
                    image: 'lib/assets/svg/arrow_back.svg',
                    width: 43.dp,
                    height: 43.dp,
                  ),
                ),
                ImageShowWidget(
                  isAsset: true,
                  image: 'lib/assets/png/espn.png',
                  width: imageWidth,
                  height: imageHeight,
                ),
                SizedBox(width: 48.dp),
              ],
            );
          }),
          centerTitle: true,
          backgroundColor: Colors.black,
          leadingWidth: 20.dp + 64.dp,
          elevation: 0,
          toolbarHeight: 109.dp,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.dp),
              bottomRight: Radius.circular(8.dp),
            ),
          ),
          titleSpacing: 20.dp,
        ),
      ),
    );
  }
}
