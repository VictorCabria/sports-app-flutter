// ignore_for_file: unused_import

import 'dart:io' show File;

import 'package:deporte_app_flutter/routes/routes_navigator_service.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'local/locator.dart';

void main() async {
  /* String apiKey =
      const String.fromEnvironment('varGoogleMapsApiKey', defaultValue: '');
  _getModifiedIndexHtml(apiKey); */
  WidgetsFlutterBinding.ensureInitialized();
  // set the orientation only vertical //
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();

  await initializeDI();
  FlutterError.onError = (errorDetails) {
    FlutterError.presentError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  RoutesNavigatorService navigatorService = getIt.get<RoutesNavigatorService>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          navigatorKey: Get.key,
          debugShowCheckedModeBanner: false,
          title: const String.fromEnvironment('varAppName', defaultValue: ''),

          //darkTheme: theme.themeDataDark,
          initialRoute: navigatorService.getInitialLoading,
          getPages: navigatorService.routes,

          //navigatorKey: GlobalKey<NavigatorState>(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // supportedLocales: const [
          //   Locale('en', 'US'),
          //   Locale('es', 'ES'),
          // ],

          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            //defaultScale: true,
            breakpoints: [
              const Breakpoint(start: 0, end: 390, name: MOBILE),
              const Breakpoint(start: 390, end: 768, name: TABLET),
              const Breakpoint(start: 768, end: 900, name: DESKTOP),
            ],
          ),
        );
      },
    );
  }
}
