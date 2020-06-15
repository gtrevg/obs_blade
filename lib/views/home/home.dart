import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_helpers/flutter_mobx_helpers.dart';
import 'package:provider/provider.dart';

import '../../stores/shared/network.dart';
import '../../stores/views/home.dart';
import '../../types/enums/response_status.dart';
import '../../utils/overlay_handler.dart';
import '../../utils/routing_helper.dart';
import 'widgets/auto_discovery/auto_discovery.dart';
import 'widgets/connect_form/connect_form.dart';
import 'widgets/refresher_app_bar/refresher_app_bar.dart';
import 'widgets/saved_connections/saved_connections.dart';
import 'widgets/switcher_card/switcher_card.dart';

class HomeView extends StatelessWidget {
  void _handleConnectionAttempt(
      BuildContext context, NetworkStore networkStore) {
    if (networkStore.connectionInProgress) {
      OverlayHandler.showStatusOverlay(
        context: context,
        showDuration: Duration(seconds: 5),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text('Connecting...'),
            ),
          ],
        ),
      );
    } else if (networkStore.connectionWasInProgress &&
        !networkStore.connectionInProgress) {
      if (networkStore.connectionResponse.status == ResponseStatus.OK.text) {
        Navigator.pushReplacementNamed(
            context, HomeTabRoutingKeys.DASHBOARD.route);
      }
      if (!networkStore.connectionResponse.error.contains('Authentication')) {
        OverlayHandler.showStatusOverlay(
          context: context,
          replaceIfActive: true,
          content: Align(
            alignment: Alignment.center,
            child: Text(
              networkStore.connectionResponse.status == ResponseStatus.OK.text
                  ? 'WebSocket connection established!'
                  : 'Couldn\'t connect to a WebSocket!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    NetworkStore networkStore = Provider.of<NetworkStore>(context);
    HomeStore landingStore = Provider.of<HomeStore>(context);

    return ObserverListener(
      listener: (_) {
        _handleConnectionAttempt(context, networkStore);
      },
      child: Scaffold(
        body: Listener(
          onPointerUp: (_) {
            if (landingStore.refreshable) {
              landingStore.updateAutodiscoverConnections();
            }
          },
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              RefresherAppBar(
                expandedHeight: 200.0,
                imagePath: 'assets/images/base-logo.png',
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 50.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Observer(
                        builder: (context) => Stack(
                          children: <Widget>[
                            SwitcherCard(
                              title: landingStore.manualMode
                                  ? 'Connection'
                                  : 'Autodiscover',
                              child: landingStore.manualMode
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 24.0,
                                          right: 24.0,
                                          bottom: 12.0),
                                      child: ConnectForm(
                                        connection:
                                            landingStore.typedInConnection,
                                        saveCredentials: true,
                                      ),
                                    )
                                  : AutoDiscovery(),
                            ),
                            Positioned(
                              right: 36.0,
                              top: 30.0,
                              child: CupertinoButton(
                                child: Text(landingStore.manualMode
                                    ? 'Auto'
                                    : 'Manual'),
                                onPressed: () =>
                                    landingStore.toggleManualMode(),
                              ),
                            )
                          ],
                        ),
                      ),
                      SavedConnections(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
