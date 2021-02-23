import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/add_account.dart';
import '../../../../domain/usecases/save_current_account.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;
  SignupCubit({
    @required this.addAccount,
    @required this.saveCurrentAccount,
  }) : super(SignupInitial());

  void handleName(String value) {}
  void handleEmail(String value) {}
  void handlePassword(String value) {}

  String get nameError => '';
  String get emailError => '';
  String get passwordError => '';
}
