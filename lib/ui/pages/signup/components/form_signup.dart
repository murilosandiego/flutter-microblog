import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../main/routes/app_routes.dart';
import '../../../components/app_button.dart';
import '../../../components/app_text_form_field.dart';
import '../../../components/create_account_button.dart';
import '../cubit/form_signup_cubit.dart';
import '../cubit/form_signup_state.dart';

class FormSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<FormSignUpCubit, FormSignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.feed,
            (route) => false,
          );
        }
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context).showSnackBar(
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
    final cubit = context.read<FormSignUpCubit>();

    return BlocBuilder<FormSignUpCubit, FormSignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
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
    final cubit = BlocProvider.of<FormSignUpCubit>(context);

    return BlocBuilder<FormSignUpCubit, FormSignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
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
  const _EmailField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FormSignUpCubit>(context);

    return BlocBuilder<FormSignUpCubit, FormSignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return AppTextFormField(
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

class _NameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FormSignUpCubit>(context);

    return BlocBuilder<FormSignUpCubit, FormSignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return AppTextFormField(
          label: 'Nome',
          onChanged: cubit.handleName,
          errorText: cubit.nameError,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
