import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../local/locator.dart';
import '../view_model/login_view_model.dart';

class LoginWidget extends LocalRootWidget<LoginWidgetModel> {
  LoginWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(LoginWidgetModel model, BuildContext context) {
    return withLoading(
      verticalResponsive: false,
      body: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 100.dp),
                Image.asset(
                  "lib/assets/png/LogoSport.png",
                  height: 150.dp,
                  width: 150.dp,
                ),
                SizedBox(
                  height: 40.dp,
                ),
                TextFormField(
                  controller: model.codeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0.dp),
                        borderSide: BorderSide(
                          color: const Color(0xFF303133).withOpacity(0.13),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 19.dp, vertical: 15.dp),
                      labelText: "Codigo"),
                ),
                SizedBox(height: 30.dp),
                ElevatedButton(
                  onPressed: () {
                    model.setApiKey(model.codeController.text);
                  },
                  child: Text('Guardar API Key'),
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
