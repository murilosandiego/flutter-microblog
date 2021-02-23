import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

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
import '../factories/usecases/load_news_factory.dart';
import '../factories/usecases/load_posts_factory.dart';
import '../factories/usecases/remove_post_factory.dart';
import '../factories/usecases/save_current_account_factory.dart';
import '../factories/usecases/save_post_factory.dart';

abstract class AppPages {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const feed = '/feed';
  static const newPost = '/newPost';
  static const signup = 'signup';

  static getRoutes(BuildContext context) {
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
      create: (_) => FormSignUpCubit(
        addAccount: AddAccountFactory.makeRemoteAddAccount(),
        saveCurrentAccount:
            SaveCurrentAccountFactory.makeLocalSaveCurrentAccount(),
      ),
      child: SignUpPage(),
    );
  }

  static BlocProvider<FeedCubit> _makeFeedPage() {
    return BlocProvider(
      create: (_) => FeedCubit(
        loadNews: LoadNewsFactory.makeRemoteLoadNews(),
        loadPosts: LoadPostsFactory.makeRemoteLoadNews(),
        savePost: SavePostFactory.makeRemoteSavePost(),
        removePost: RemovePostFactory.makeRemoteRemovePost(),
        localStorage: LocalStorage('app_local'),
      ),
      child: FeedPageCubit(),
    );
  }

  static BlocProvider<FormLoginCubit> _makeLoginPage() {
    return BlocProvider(
      create: (context) => FormLoginCubit(
        authetication: AutheticationFactory.makeRemoteAuthetication(),
        saveCurrentAccount:
            SaveCurrentAccountFactory.makeLocalSaveCurrentAccount(),
      ),
      child: LoginPage(),
    );
  }

  static BlocProvider<SplashCubit> _makeSplashPage() {
    return BlocProvider(
      create: (_) => SplashCubit(
        loadCurrentAccount: makeLocalLoadCurrentAccount(),
      ),
      child: SplashPage(),
    );
  }

  // static final pages = [
  //   GetPage(
  //     name: splash,
  //     page: () => SplashPage(),
  //     binding: SplashBinding(),
  //   ),
  //   GetPage(
  //     name: welcome,
  //     page: () => WelcomePage(),
  //   ),
  //   GetPage(
  //     name: login,
  //     page: () => LoginPage(),
  //     binding: LoginBinding(),
  //     transition: Transition.downToUp,
  //   ),
  //   GetPage(
  //     name: signup,
  //     page: () => SignUpPage(),
  //     binding: SignupBinding(),
  //     transition: Transition.downToUp,
  //   ),
  // GetPage(
  //   name: feed,
  //   page: () => FeedPage(),
  //   binding: FeedBinding(),
  // ),
  // GetPage(
  //   name: feed,
  //   page: () => FeedPageCubit(),
  //   binding: FeedBinding(),
  // ),
  // GetPage(
  //   name: newPost,
  //   page: () => NewPostPage(),
  //   transition: Transition.downToUp,
  // ),
  // ];
}
