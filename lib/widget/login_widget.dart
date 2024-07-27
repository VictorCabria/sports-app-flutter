import 'package:deporte_app_flutter/widget/image_show_widget.dart';
import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../local/locator.dart';
import '../view_model/login_view_model.dart';

class LoginWidget extends LocalRootWidget<LoginWidgetModel> {
  LoginWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(LoginWidgetModel model, BuildContext context) {
    return withLoading(
      verticalResponsive: false,
      body: Scaffold(
        backgroundColor: const Color(0xFFF6F6F8),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: AutofillGroup(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 400.dp,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 70.dp),
                    ImageShowWidget(
                      isAsset: true,
                      image: 'lib/assets/png/LogoSport.png',
                      width: 150.dp,
                      height: 150.dp,
                    ),
                    SizedBox(height: 60.dp),
                    Text(
                      "Bienvenido",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF1F1646),
                        fontSize: 24.dp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.48.dp,
                      ),
                    ),
                    SizedBox(height: 10.dp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.dp),
                      child: Text(
                        "Ingrese su Apikey para poder ingresar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF798290),
                          fontSize: 16.dp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.2.dp,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.dp),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.dp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 14.dp),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: 400.dp,
                            ),
                            child: TextFormField(
                              controller: model.codeController,
                              autofillHints: const [AutofillHints.username],
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "ApiKey",
                                labelStyle: TextStyle(
                                  color: const Color(0xFF838F95),
                                  fontSize: 14.dp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.50.dp,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: const Color(0xFF909194),
                                  fontSize: 14.dp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.40.dp,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0.dp),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF303133)
                                        .withOpacity(0.13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 14.dp),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.dp),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.dp),
                      child: ElevatedButton(
                        onPressed: () {
                          model.setApiKey(model.codeController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.dp, vertical: 10.dp),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.dp),
                          ),
                          minimumSize: Size(326.dp, 40.dp),
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          "Ingresar",
                          style: TextStyle(
                            color: const Color(0xFFF5FAFC),
                            fontSize: 16.dp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.10.dp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.dp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.dp),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: const Color(0xFF798290),
                            fontSize: 14.dp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.10.dp,
                          ),
                          children: [
                            TextSpan(text: "Obtener el apikey "),
                            TextSpan(
                                text: "aquí",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    model.launchurl();
                                  }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.dp),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      model: model,
      context: context,
    );
  }
}
