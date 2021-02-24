import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/routes/app_routes.dart';
import '../../components/logo_widget.dart';
import 'cubit/splash_cubit.dart';
import 'cubit/splash_state.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SplashCubit>();
    cubit.checkAccount();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
          child: BlocListener<SplashCubit, SplashState>(
        listener: (_, state) {
          if (state is SplashToWelcome) {
            Navigator.popAndPushNamed(_, AppRoutes.welcome);
          }

          if (state is SplashToHome) {
            Navigator.popAndPushNamed(_, AppRoutes.feed);
          }
        },
        child: LogoWidget(),
      )),
    );
  }
}
