import 'package:deporte_app_flutter/widget/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: EdgeInsets.all(8.0.dp),
          child: Column(
            children: [
              _buildStatisticsView(model),
              const Divider(
                color: Colors.white,
              ),
              Container(
                height: 45.dp,
                decoration: BoxDecoration(
                  color: const Color(0xFF040404),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: const Color(0xFF47484A),
                  ),
                  splashFactory: NoSplash.splashFactory,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.onSurfaceVariant,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  indicatorColor: Colors.red,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            model.fixtures!.homeTeamLogo!,
                            width: 24.dp,
                            height: 24.dp,
                          ),
                          SizedBox(width: 8.dp),
                          Text(
                            model.fixtures!.eventHomeFormation ?? "N/A",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.dp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            model.fixtures!.awayTeamLogo!,
                            width: 24.dp,
                            height: 24.dp,
                          ),
                          SizedBox(width: 8.dp),
                          Text(
                            model.fixtures!.eventAwayFormation ?? "N/A",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.dp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildScrollableTab(
                      model,
                      _buildCampoHome(model),
                      model.fixtures!.lineups!.homeTeam!,
                      model.fixtures!.lineups!.homesubstitutes!,
                    ),
                    _buildScrollableTab(
                      model,
                      _buildCampoAway(model),
                      model.fixtures!.lineups!.awayTeam!,
                      model.fixtures!.lineups!.awaysubstitutes!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      model: model,
      context: context,
    );
  }

  Widget _buildScrollableTab(TabLineupsViewModel model, Widget campo,
      List<Player> starters, List<Player> substitutes) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.dp),
          Center(child: campo),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildSectionTitle('Titulares'),
                    _buildPlayerList(starters),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    _buildSectionTitle('Suplentes'),
                    _buildPlayerList(substitutes),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.dp),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.dp,
          fontWeight: FontWeight.bold,
        ),
      ),
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

  Widget _buildCampoHome(TabLineupsViewModel model) {
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
          model.buildFormation(model.fixtures!.eventHomeFormation!,
              model.fixtures!.lineups!.homeTeam!),
        ],
      ),
    );
  }

  Widget _buildCampoAway(TabLineupsViewModel model) {
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
          model.buildFormation(model.fixtures!.eventAwayFormation!,
              model.fixtures!.lineups!.awayTeam!),
        ],
      ),
    );
  }

  Widget _buildPlayerList(List<Player> players) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: players.length,
      itemBuilder: (context, index) {
        Player player = players[index];
        return ListTile(
          leading: Text(
            player.playerNumber.toString(),
            style: TextStyle(color: Colors.white, fontSize: 14.dp),
          ),
          title: Text(
            player.player ?? '',
            style: TextStyle(color: Colors.white, fontSize: 14.dp),
          ),
          subtitle: Text(
            player.playerPosition.toString(),
            style: TextStyle(color: Colors.white70, fontSize: 12.dp),
          ),
        );
      },
    );
  }
}
