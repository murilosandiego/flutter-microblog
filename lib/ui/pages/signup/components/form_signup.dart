import 'package:boticario_news/main/providers/providers.dart';
import 'package:boticario_news/ui/helpers/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../../main/routes/app_routes.dart';
import '../../../components/app_button.dart';
import '../../../components/app_text_form_field.dart';
import '../../../components/create_account_button.dart';
import '../cubit/form_signup_state.dart';

class FormSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<FormSignUpState>(
      provider: signUpProvider,
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
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 42),
        child: Column(
          children: [
            _NameField(),
            SizedBox(height: 26),
            _EmailField(),
            SizedBox(height: 26),
            _PasswordField(),
            SizedBox(height: 26),
            _SubmitButton(),
            SizedBox(height: 32),
            CreateAccountButton(
              nameButton: 'Já tem conta? Fazer login',
              onPressed: () =>
                  Navigator.popAndPushNamed(context, AppRoutes.login),
              backgroundWhite: true,
            )
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read(signUpProvider.notifier);

    return Consumer(
      builder: (context, watch, state) {
        final state = watch(signUpProvider);

        return AppButton(
          isLoading: state.status.isSubmissionInProgress,
          text: 'Criar conta',
          textColor: Colors.white,
          onPressed: state.status.isValid ? () => cubit.add() : null,
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read(signUpProvider.notifier);

    return Consumer(
      builder: (context, watch, state) {
        final state = watch(signUpProvider);

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
  const _EmailField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read(signUpProvider.notifier);

    return Consumer(
      builder: (context, watch, state) {
        final state = watch(signUpProvider);

        return AppTextFormField(
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

class _NameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read(signUpProvider.notifier);

    return Consumer(
      builder: (context, watch, state) {
        final state = watch(signUpProvider);

        return AppTextFormField(
          label: 'Nome',
          onChanged: cubit.handleName,
          errorText: state.name.errorMessage,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
