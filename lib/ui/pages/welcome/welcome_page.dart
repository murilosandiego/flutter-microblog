import 'package:flutter/material.dart';

import '../../components/logo_widget.dart';
import 'components/buttons.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LogoWidget(),
              SizedBox(height: 100),
              Buttons(),
            ],
          ),
        ),
      ),
    );
  }
}
