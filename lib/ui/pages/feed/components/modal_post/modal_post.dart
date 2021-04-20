import 'package:boticario_news/main/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../../helpers/form_validators.dart';
import '../../post_viewmodel.dart';

Future<String> showModalPost(BuildContext context, {NewsViewModel news}) {
  return showDialog<String>(
    context: context,
    builder: (context) => _Alert(
      news: news,
    ),
  );
}

class _Alert extends StatelessWidget {
  final NewsViewModel news;
  const _Alert({@required this.news});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read(formPostProvider.notifier);

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text('Criar publicação'),
      content: Consumer(
        builder: (_, watch, __) {
          final state = watch(formPostProvider);

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
          child: Consumer(
            builder: (_, watch, __) {
              final state = watch(formPostProvider);

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
