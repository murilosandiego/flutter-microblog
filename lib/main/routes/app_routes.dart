import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infra/storage/local_storage_adater.dart';
import '../../ui/helpers/user_manager.dart';
import '../../ui/pages/feed/cubit/feed_cubit.dart';
import '../../ui/pages/feed/feed_page.dart';
import '../../ui/pages/login/cubit/form_cubit.dart';
import '../../ui/pages/login/login_page.dart';
import '../../ui/pages/signup/cubit/form_signup_cubit.dart';
import '../../ui/pages/signup/signup_page.dart';
import '../../ui/pages/splash/cubit/splash_cubit.dart';
import '../../ui/pages/splash/splash_page.dart';
import '../../ui/pages/welcome/welcome_page.dart';
import '../factories/usecases/add_account_factory.dart';
import '../factories/usecases/authetication.dart';
import '../factories/usecases/load_current_account_factory.dart';
import '../factories/usecases/load_posts_factory.dart';
import '../factories/usecases/remove_post_factory.dart';
import '../factories/usecases/save_current_account_factory.dart';
import '../factories/usecases/save_post_factory.dart';
import '../singletons/local_storage_singleton.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const feed = '/feed';
  static const newPost = '/new-post';
  static const signup = 'signup';

  static getRoutes(_) {
    final Map<String, WidgetBuilder> routes = {
      splash: (_) => _makeSplashPage(),
      welcome: (_) => WelcomePage(),
      signup: (_) => _makeSignUpPage(),
      login: (_) => _makeLoginPage(),
      feed: (_) => _makeFeedPage(),
    };

    return routes;
  }

  static BlocProvider<FormSignUpCubit> _makeSignUpPage() {
    return BlocProvider(
      create: (context) => FormSignUpCubit(
        addAccount: AddAccountFactory.makeRemoteAddAccount(),
        saveCurrentAccount:
            SaveCurrentAccountFactory.makeLocalSaveCurrentAccount(),
        userManager: context.read<UserManager>(),
      ),
      child: SignUpPage(),
    );
  }

  static BlocProvider<FeedCubit> _makeFeedPage() {
    return BlocProvider(
      create: (_) => FeedCubit(
        loadPosts: LoadPostsFactory.makeRemoteLoadNews(),
        savePost: SavePostFactory.makeRemoteSavePost(),
        removePost: RemovePostFactory.makeRemoteRemovePost(),
        localStorage: LocalStorageAdapter(
          localStorage: LocalStorage.instance.preferences,
        ),
      ),
      child: FeedPage(),
    );
  }

  static BlocProvider<FormLoginCubit> _makeLoginPage() {
    return BlocProvider(
      create: (context) => FormLoginCubit(
          authetication: AutheticationFactory.makeRemoteAuthetication(),
          saveCurrentAccount:
              SaveCurrentAccountFactory.makeLocalSaveCurrentAccount(),
          userManager: context.read<UserManager>()),
      child: LoginPage(),
    );
  }

  static BlocProvider<SplashCubit> _makeSplashPage() {
    return BlocProvider(
      create: (context) => SplashCubit(
        loadCurrentAccount: makeLocalLoadCurrentAccount(),
        userManager: context.read<UserManager>(),
      ),
      child: SplashPage(),
    );
  }
}
