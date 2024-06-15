import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';

import '../local/locator.dart';
import '../view_model/login_view_model.dart';

class LoginWidget extends LocalRootWidget<LoginWidgetModel> {
  LoginWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(LoginWidgetModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        appBar: AppBar(
          title: Text('Ingresar API Key'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: model.codeController,
                decoration: InputDecoration(labelText: "Codigo"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  model.setApiKey(model.codeController.text);
                  // Navegar a la página principal o hacer otra acción
                },
                child: Text('Guardar API Key'),
              ),
            ],
          ),
        ),
      ),
      model: model,
      context: context,
    );
  }
}
