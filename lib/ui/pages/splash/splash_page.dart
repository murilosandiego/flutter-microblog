import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/pages/app_pages.dart';
import '../../components/logo_widget.dart';
import 'cubit/splash_cubit.dart';

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
            Navigator.popAndPushNamed(_, AppPages.welcome);
          }

          if (state is SplashToHome) {
            Navigator.popAndPushNamed(_, AppPages.feed);
          }
        },
        child: LogoWidget(),
      )),
    );
  }
}
