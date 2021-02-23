import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'main/pages/app_pages.dart';
import 'ui/components/app_theme.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubit Microblog',
      theme: makeAppTheme(),
      routes: AppPages.getRoutes(context),
      initialRoute: AppPages.splash,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}
