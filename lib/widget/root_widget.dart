import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../view_model/root_view_model.dart';

abstract class LocalRootWidget<T extends RootViewModel> extends GetView<T> {
  final T _model;

  get model => _model;

  LocalRootWidget(this._model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        widget(model, context),
        Obx(
          () => Visibility(
            visible: model.internetConnectionError.value,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return constraints.maxHeight < 350
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Theme.of(context).colorScheme.errorContainer,
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: 350,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_off,
                                  size: 100.dp,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer,
                                ),
                                SizedBox(height: 10.dp),
                                Text(
                                  model.languageService
                                      .translate("NO_INTERNET"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer,
                                      ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    model.internetConnectionTryAgain();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer,
                                        ),
                                  ),
                                  child: Text(
                                    model.languageService
                                        .translate("TRY_AGAIN"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Theme.of(context).colorScheme.errorContainer,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wifi_off,
                              size: 100.dp,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                            ),
                            SizedBox(height: 10.dp),
                            Text(
                              model.languageService.translate("NO_INTERNET"),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer,
                                  ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                model.internetConnectionTryAgain();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onErrorContainer,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .errorContainer,
                                    ),
                              ),
                              child: Text(
                                model.languageService.translate("TRY_AGAIN"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .errorContainer,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget widget(T model, BuildContext context);

  Widget withLoading({
    required Widget body,
    required T model,
    required BuildContext context,
    bool verticalResponsive = true,
    double minHeight = 350,
  }) {
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxHeight < minHeight && verticalResponsive
          ? SingleChildScrollView(
              child: SizedBox(
                height: minHeight,
                child: Stack(
                  children: [
                    body,
                    Positioned.fill(
                      child: Obx(
                        () => model.loading.value
                            ? Container(
                                color: Colors.black.withOpacity(0.5),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Container(),
                      ),
                    ),
                    Positioned.fill(
                      child: Obx(
                        () => model.showErrorString.value.isNotEmpty
                            ? Container(
                                color: Colors.black.withOpacity(0.2),
                                child: Center(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minWidth: 300.dp,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .errorContainer,
                                      borderRadius:
                                          BorderRadius.circular(10.dp),
                                    ),
                                    padding: EdgeInsets.all(10.dp),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.error,
                                          size: 100.dp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onErrorContainer,
                                        ),
                                        SizedBox(height: 10.dp),
                                        Text(""),
                                        Text(
                                          model.showErrorString.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onErrorContainer,
                                              ),
                                        ),
                                        SizedBox(height: 10.dp),
                                        ElevatedButton.icon(
                                          onPressed: model.hideError,
                                          icon: Icon(
                                            Icons.close,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onError,
                                          ),
                                          label: Text(""),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .onErrorContainer,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.dp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              child: Stack(
                children: [
                  body,
                  Positioned.fill(
                    child: Obx(
                      () => model.loading.value
                          ? Container(
                              color: Colors.black.withOpacity(0.5),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Container(),
                    ),
                  ),
                  Positioned.fill(
                    child: Obx(
                      () => model.showErrorString.value.isNotEmpty
                          ? Container(
                              color: Colors.black.withOpacity(0.2),
                              child: Center(
                                child: Container(
                                  constraints: BoxConstraints(
                                    minWidth: 300.dp,
                                    maxWidth: 300.dp,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(16.dp),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.dp, vertical: 20.dp),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 260.dp,
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: model.hideError,
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: 20.dp,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.dp),
                                      SizedBox(
                                        width: 260.dp,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          model.labelErrorTitle.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                        ),
                                      ),
                                      SizedBox(height: 10.dp),
                                      SizedBox(
                                        width: 270.dp,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          model.showErrorString.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              ),
                                        ),
                                      ),
                                      SizedBox(height: 10.dp),
                                      SvgPicture.asset(
                                        'lib/assets/svg/image_show_error.svg',
                                        width: 215.dp,
                                        height: 170.dp,
                                      ),
                                      SizedBox(height: 15.dp),
                                      SizedBox(
                                        width: 260.dp,
                                        child: OutlinedButton.icon(
                                          onPressed: model.hideError,
                                          icon: Icon(
                                            Icons.close,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          label: Text(
                                            model.textButtonError.value
                                                .toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.dp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
