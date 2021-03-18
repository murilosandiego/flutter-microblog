import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../helpers/form_validators.dart';
import '../../post_viewmodel.dart';
import 'cubit/form_post_cubit.dart';

Future<String> showModalPost(BuildContext context, {NewsViewModel news}) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return BlocProvider(
        create: (context) => FormPostCubit(),
        child: _Alert(
          news: news,
        ),
      );
    },
  );
}

class _Alert extends StatelessWidget {
  final NewsViewModel news;
  const _Alert({@required this.news});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FormPostCubit>();
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text('Criar publicação'),
      content: BlocBuilder<FormPostCubit, FormPostState>(
        builder: (context, state) {
          return TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'O que deseja compartilhar?',
              errorText: state.message.errorMessage,
              errorBorder: InputBorder.none,
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              fillColor: Theme.of(context).backgroundColor,
              filled: true,
              contentPadding: EdgeInsets.zero,
            ),
            maxLines: null,
            onChanged: cubit.handleMessage,
            initialValue: news?.message ?? '',
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: BlocBuilder<FormPostCubit, FormPostState>(
            builder: (_, state) {
              return TextButton(
                onPressed: state.status.isValid
                    ? () {
                        Navigator.of(context).pop(
                          state.message.value,
                        );
                      }
                    : null,
                child: Text(
                  'Publicar',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
