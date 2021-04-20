import 'package:boticario_news/main/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../../main/routes/app_routes.dart';
import '../../../components/app_button.dart';
import '../../../components/app_text_form_field.dart';
import '../../../components/create_account_button.dart';
import '../../../helpers/form_validators.dart';
import '../cubit/form_state.dart';

class FormLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<FormLoginState>(
      provider: signInProvider,
      onChange: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.feed,
            (route) => false,
          );
        }
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 42),
        child: Column(
          children: [
            _EmailField(),
            SizedBox(height: 26),
            _PasswordField(),
            SizedBox(height: 32),
            _SubmitButton(),
            SizedBox(height: 32),
            CreateAccountButton(
              onPressed: () =>
                  Navigator.popAndPushNamed(context, AppRoutes.signup),
              backgroundWhite: true,
            )
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read(signInProvider.notifier);

    return Consumer(
      builder: (_, watch, state) {
        final state = watch(signInProvider);

        return AppButton(
          isLoading: state.status.isSubmissionInProgress,
          text: 'Login',
          textColor: Colors.white,
          onPressed: state.status.isValid ? () => cubit.auth() : null,
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read(signInProvider.notifier);

    return Consumer(
      builder: (_, watch, __) {
        final state = watch(signInProvider);

        return AppTextFormField(
          label: 'Senha',
          onChanged: cubit.handlePassword,
          errorText: state.password.errorMessage,
          obscureText: true,
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read(signInProvider.notifier);

    return Consumer(
      builder: (_, watch, __) {
        final state = watch(signInProvider);

        return AppTextFormField(
          initialValue: state.email.value,
          label: 'E-mail',
          onChanged: cubit.handleEmail,
          errorText: state.email.errorMessage,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
