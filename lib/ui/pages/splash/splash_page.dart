import 'package:boticario_news/main/providers/providers.dart';
import 'package:flutter/material.dart';

import '../../../main/routes/app_routes.dart';
import '../../components/logo_widget.dart';
import 'cubit/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read(splashProvider.notifier);
    cubit.checkAccount();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: ProviderListener(
          provider: splashProvider,
          onChange: (_, state) {
            if (state is SplashToWelcome) {
              Navigator.popAndPushNamed(_, AppRoutes.welcome);
            }

            if (state is SplashToHome) {
              Navigator.popAndPushNamed(_, AppRoutes.feed);
            }
          },
          child: LogoWidget(),
        ),
      ),
    );
  }
}
