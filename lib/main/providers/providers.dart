import 'package:boticario_news/ui/pages/feed/components/modal_post/cubit/form_post_cubit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infra/storage/local_storage_adater.dart';
import '../../ui/helpers/user_manager.dart';
import '../../ui/pages/feed/cubit/feed_cubit.dart';
import '../../ui/pages/feed/cubit/feed_state.dart';
import '../../ui/pages/login/cubit/form_cubit.dart';
import '../../ui/pages/login/cubit/form_state.dart';
import '../../ui/pages/signup/cubit/form_signup_cubit.dart';
import '../../ui/pages/signup/cubit/form_signup_state.dart';
import '../../ui/pages/splash/cubit/splash_cubit.dart';
import '../factories/usecases/add_account_factory.dart';
import '../factories/usecases/authetication.dart';
import '../factories/usecases/load_current_account_factory.dart';
import '../factories/usecases/load_posts_factory.dart';
import '../factories/usecases/remove_post_factory.dart';
import '../factories/usecases/save_current_account_factory.dart';
import '../factories/usecases/save_post_factory.dart';
import '../singletons/local_storage_singleton.dart';

final userManagerProvider = ChangeNotifierProvider((ref) => UserManager());

final splashProvider = StateNotifierProvider.autoDispose(
  (ref) => SplashCubit(
    loadCurrentAccount: makeLocalLoadCurrentAccount(),
    userManager: ref.read(userManagerProvider),
  ),
);

final signUpProvider =
    StateNotifierProvider.autoDispose<FormSignUpCubit, FormSignUpState>(
  (ref) => FormSignUpCubit(
    addAccount: AddAccountFactory.makeRemoteAddAccount(),
    saveCurrentAccount: SaveCurrentAccountFactory.makeLocalSaveCurrentAccount(),
    userManager: ref.read(userManagerProvider),
  ),
);

final signInProvider =
    StateNotifierProvider.autoDispose<FormLoginCubit, FormLoginState>(
  (ref) => FormLoginCubit(
    authetication: AutheticationFactory.makeRemoteAuthetication(),
    saveCurrentAccount: SaveCurrentAccountFactory.makeLocalSaveCurrentAccount(),
    userManager: ref.read(userManagerProvider),
  ),
);

final feedProvider = StateNotifierProvider.autoDispose<FeedCubit, FeedState>(
  (ref) => FeedCubit(
    loadPosts: LoadPostsFactory.makeRemoteLoadNews(),
    savePost: SavePostFactory.makeRemoteSavePost(),
    removePost: RemovePostFactory.makeRemoteRemovePost(),
    localStorage: LocalStorageAdapter(
      localStorage: LocalStorage.instance.preferences,
    ),
  ),
);

final formPostProvider =
    StateNotifierProvider.autoDispose<FormPostCubit, FormPostState>(
  (ref) => FormPostCubit(),
);
