import 'package:boticario_news/main/pages/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../components/app_button.dart';
import '../../../components/app_text_form_field.dart';
import '../../../components/create_account_button.dart';
import '../cubit/form_cubit.dart';

class FormLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<FormLoginCubit, FormLoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppPages.feed,
            (route) => false,
          );
        }
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context).showSnackBar(
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
                  Navigator.popAndPushNamed(context, AppPages.signup),
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
    final cubit = context.read<FormLoginCubit>();
    return BlocBuilder<FormLoginCubit, FormLoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
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
    final cubit = context.read<FormLoginCubit>();
    return BlocBuilder<FormLoginCubit, FormLoginState>(
      buildWhen: (previous, current) =>
          previous.password.value != current.password.value,
      builder: (context, state) {
        return AppTextFormField(
          label: 'Senha',
          onChanged: cubit.handlePassword,
          errorText: cubit.passwordError,
          obscureText: true,
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FormLoginCubit>();
    return BlocBuilder<FormLoginCubit, FormLoginState>(
      buildWhen: (previous, current) {
        return previous.email.value != current.email.value;
      },
      cubit: cubit,
      builder: (context, state) {
        return AppTextFormField(
          initialValue: state.email.value,
          label: 'E-mail',
          onChanged: cubit.handleEmail,
          errorText: cubit.emailError,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
