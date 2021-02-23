import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main/pages/app_pages.dart';
import '../../../components/app_button.dart';
import '../../../components/app_text_form_field.dart';
import '../../../components/create_account_button.dart';
import '../cubit/signup_cubit.dart';

class FormSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignupCubit>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 42),
      child: Column(
        children: [
          AppTextFormField(
            label: 'Nome',
            onChanged: cubit.handleName,
            errorText: cubit.nameError,
            textInputAction: TextInputAction.next,
          ),
          // SizedBox(height: 26),
          AppTextFormField(
            label: 'E-mail',
            onChanged: cubit.handleEmail,
            errorText: cubit.emailError,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          // SizedBox(height: 26),
          AppTextFormField(
            label: 'Senha',
            onChanged: cubit.handlePassword,
            errorText: cubit.passwordError,
            obscureText: true,
          ),
          SizedBox(height: 16),
          AppButton(
            isLoading: false,
            text: 'Criar conta',
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 32),
          CreateAccountButton(
            nameButton: 'Já tem conta? Fazer login',
            onPressed: () => Navigator.popAndPushNamed(context, AppPages.login),
            backgroundWhite: true,
          )
        ],
      ),
    );
  }
}
