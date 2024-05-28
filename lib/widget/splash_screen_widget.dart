import 'package:flutter/material.dart';
//import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../../di/locator.dart';
import '../view_model/splah_screen_view_model.dart';
import 'root_widget.dart';

class SplashScreenWidget extends LocalRootWidget<SplashScreenViewModel> {
  SplashScreenWidget() : super(getIt());

  @override
  Widget widget(SplashScreenViewModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Visibility(
                    visible: model.showLogo.value &&
                        (model.configSplashScreen.value.isGif ?? false),
                    child: (model.configSplashScreen.value.isLocal ?? true)
                        ? Image.asset(
                            model.configSplashScreen.value.path ??
                                "", //"lib/assets/gif/logo_tutti_splashscreen.gif",
                            height: 400.dp,
                            width: 400.dp,
                            repeat: ImageRepeat.noRepeat,
                            frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                              //print("wasSynchronouslyLoaded: ");
                              //print("frame builder: ");
                              return model.onFetchData(frame ?? 0, child);
                            },
                            errorBuilder: (context, error, stackTrace) {
                              //print("error: ");
                              //print("stackTrace: ");
                              return Container();
                            },
                          )
                        : Image.network(
                            model.configSplashScreen.value.path ?? "",
                            height: 400.dp,
                            width: 400.dp,
                            repeat: ImageRepeat.noRepeat,
                            frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                              //print("wasSynchronouslyLoaded: ");
                              //print("frame builder: ");
                              return model.onFetchData(frame ?? 0, child);
                            },
                            errorBuilder: (context, error, stackTrace) {
                              //print("error: ");
                              //print("stackTrace: ");
                              return Container();
                            },
                          ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: model.showLogo.value &&
                        (model.configSplashScreen.value.isImage ?? false),
                    child: TweenAnimationBuilder<double>(
                      curve: Curves.easeInOutBack,
                      duration: const Duration(
                          seconds:
                              5), // Ajusta la duración según tus preferencias
                      tween: Tween(begin: 0.5, end: 0.8),
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child:
                              (model.configSplashScreen.value.isLocal ?? true)
                                  ? Image.asset(
                                      model.configSplashScreen.value.path ?? "",
                                      height: 400.dp,
                                      width: 400.dp,
                                    )
                                  : Image.network(
                                      model.configSplashScreen.value.path ?? "",
                                      height: 400.dp,
                                      width: 400.dp,
                                    ),
                        );
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: model.loading.value,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      model: model,
      context: context,
    );
  }
}
