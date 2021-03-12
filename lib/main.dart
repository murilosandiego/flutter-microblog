import 'package:boticario_news/main/routes/app_routes.dart';
import 'package:boticario_news/main/singletons/local_storage_singleton.dart';
import 'package:boticario_news/ui/helpers/user_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'ui/components/app_theme.dart';

void main() async {
  await _initializer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
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
      ),
    );
  }
}

Future<void> _initializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.instance.init();
}
