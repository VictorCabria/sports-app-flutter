import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../local/locator.dart';
import '../view_model/user_profile_view_model.dart';

class UserProfileWidget extends LocalRootWidget<UserProfileModel> {
  UserProfileWidget({Key? key}) : super(getIt(), key: key);

  @override
  Widget widget(UserProfileModel model, BuildContext context) {
    return withLoading(
        body: Scaffold(
            backgroundColor: const Color(0xFF121212),
            appBar: CustomAppBar(model: model),
            body: Center(
                child: Container(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 5.dp, vertical: 5.dp),
              child: Column(children: [
                SizedBox(
                  height: 20.dp,
                ),
                CircleAvatar(
                    radius: 70.dp,
                    backgroundImage: const AssetImage(
                      "lib/assets/png/foto.png",
                    )),
                SizedBox(
                  height: 15.dp,
                ),
                Text(
                  "Victor Cabria",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0.dp,
                  ),
                ),
                SizedBox(
                  height: 15.dp,
                ),
                Container(
                  padding: EdgeInsetsDirectional.symmetric(
                      vertical: 10.dp, horizontal: 15.dp),
                  child: Text(
                    "Soy un desarrollador de aplicaciones móviles con 2 años de experiencia en el desarrollo de aplicaciones multiplataforma utilizando Dart y el framework Flutter. Durante mi trayectoria profesional, he trabajado en diversos proyectos donde he utilizado Firebase como plataforma de backend, además de tener experiencia en la integración y consumo de APIs externas para obtener y enviar datos entre la aplicación y servicios web. ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0.dp,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 15.dp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      model: model,
                      icon: FontAwesomeIcons.github,
                      colors: Colors.grey,
                      text: 'GitHub',
                      url: Uri.parse('https://github.com/VictorCabria'),
                    ),
                    CustomButton(
                      model: model,
                      icon: FontAwesomeIcons.linkedin,
                      colors: Colors.grey,
                      text: 'Linkedin',
                      url:
                          Uri.parse('https://www.linkedin.com/in/victorcabria'),
                    )
                  ],
                ),
              ]),
            ))),
        model: model,
        context: context);
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final UserProfileModel model;

  CustomAppBar({super.key, required this.model})
      : preferredSize = Size.fromHeight(70.dp);

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
      centerTitle: true,
      title: Text(
        'Perfil del desarrollador',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0.dp,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final Color colors;
  final String text;
  final Uri url;
  final UserProfileModel model;
  const CustomButton({
    super.key,
    required this.model,
    required this.icon,
    required this.colors,
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: FaIcon(icon),
      onPressed: () {
        model.launurlreds(url);
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.dp),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(colors),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
      ),
      label: Text(
        text,
      ),
    );
  }
}
