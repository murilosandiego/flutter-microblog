import '../../../../main/pages/app_pages.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../main/pages/app_pages.dart';
import '../../../components/app_button.dart';
import '../../../components/create_account_button.dart';

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppButton(
            text: 'Fazer login',
            textColor: Theme.of(context).primaryColor,
            color: Colors.white,
            onPressed: () => Navigator.pushNamed(context, AppPages.login),
          ),
        ),
        SizedBox(height: 32),
        CreateAccountButton(
          onPressed: () => Navigator.pushNamed(context, AppPages.signup),
          backgroundWhite: false,
        ),
      ],
    );
  }
}
