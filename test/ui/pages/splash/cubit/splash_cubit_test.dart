import 'package:boticario_news/domain/entities/account_entity.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';
import 'package:boticario_news/domain/usecases/load_current_account.dart';
import 'package:boticario_news/ui/helpers/user_manager.dart';
import 'package:boticario_news/ui/pages/splash/cubit/splash_cubit.dart';
import 'package:boticario_news/ui/pages/splash/cubit/splash_state.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

class UserManagerSpy extends Mock implements UserManager {}

main() {
  SplashCubit sut;
  LoadCurrentAccountSpy loadCurrentAccount;
  UserManagerSpy userManager;
  AccountEntity accountEntity;

  mockLoadAccountWithAccount() =>
      when(loadCurrentAccount.load()).thenAnswer((_) async => accountEntity);

  mockLoadAccountWithoutAccount() =>
      when(loadCurrentAccount.load()).thenAnswer((_) async => null);

  mockLoadAccountWithoutError() =>
      when(loadCurrentAccount.load()).thenThrow(DomainError.unexpected);

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    userManager = UserManagerSpy();

    sut = SplashCubit(
      loadCurrentAccount: loadCurrentAccount,
      userManager: userManager,
    );
    accountEntity = AccountEntity(
      token: faker.guid.guid(),
      id: faker.randomGenerator.integer(10),
      username: faker.person.name(),
      email: faker.internet.email(),
    );
  });

  blocTest<SplashCubit, SplashState>(
    'Should call LoadCurrentAccount with success',
    build: () => sut,
    act: (cubit) => cubit.checkAccount(),
    verify: (_) {
      verify(loadCurrentAccount.load()).called(1);
    },
  );

  blocTest<SplashCubit, SplashState>(
    'Should emits [SplashToHome] if has account',
    build: () {
      mockLoadAccountWithAccount();
      return sut;
    },
    act: (cubit) => cubit.checkAccount(),
    expect: [
      SplashToHome(),
    ],
  );

  blocTest<SplashCubit, SplashState>(
    'Should emits [SplashToWelcome] if has not account',
    build: () {
      mockLoadAccountWithoutAccount();
      return sut;
    },
    act: (cubit) => cubit.checkAccount(),
    expect: [
      SplashToWelcome(),
    ],
  );

  blocTest<SplashCubit, SplashState>(
    'Should emits [SplashToWelcome] if error occurs',
    build: () {
      mockLoadAccountWithoutError();
      return sut;
    },
    act: (cubit) => cubit.checkAccount(),
    expect: [
      SplashToWelcome(),
    ],
  );
}
