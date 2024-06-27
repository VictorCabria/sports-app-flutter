import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../local/locator.dart';
import '../model/configs/fixtures.dart';
import '../view_model/tablineups_view_model.dart';

class TablineUpsWidget extends LocalRootWidget<TabLineupsViewModel> {
  Fixtures? fixtures;
  TablineUpsWidget({
    required this.fixtures,
    super.key,
  }) : super(getIt()) {
    model.setresult(fixtures);
  }

  @override
  Widget widget(TabLineupsViewModel model, BuildContext context) {
    return withLoading(
      body: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Padding(
          padding: EdgeInsets.all(8.0.dp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildStatisticsView(model),
                const Divider(
                  color: Colors.white,
                ),
                _buildCampo(model)
              ],
            ),
          ),
        ),
      ),
      model: model,
      context: context,
    );
  }

  Widget _buildStatisticsView(TabLineupsViewModel model) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10.dp),
          Text(
            'Alineacion del Partidos',
            style: TextStyle(fontSize: 12.dp, color: Colors.white),
          ),
          SizedBox(height: 10.dp),
        ],
      ),
    );
  }

  Widget _buildCampo(TabLineupsViewModel model) {
    return Container(
      width: 450.dp,
      height: 350.dp,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(-0.9),
            alignment: Alignment.topCenter,
            child: Image.asset(
              'lib/assets/jpg/1137.jpg',
              fit: BoxFit.cover,
            ),
          ),
          model.buildFormation(model.fixtures!
              .eventHomeFormation!), // Cambia esto con la formación obtenida de `model`
        ],
      ),
    );
  }
}
