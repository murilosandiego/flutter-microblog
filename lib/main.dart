import 'package:boticario_news/main/routes/app_routes.dart';
import 'package:boticario_news/main/singletons/local_storage_singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/components/app_theme.dart';

void main() async {
  await _initializer();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Microblog',
      theme: makeAppTheme(),
      routes: AppRoutes.getRoutes(context),
      initialRoute: AppRoutes.splash,
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

Future<void> _initializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.instance.init();
}
