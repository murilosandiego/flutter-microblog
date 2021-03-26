import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../post_viewmodel.dart';

Future<int> showModalRemove({
  @required NewsViewModel news,
  @required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Remover publicação?'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, news.id);
          },
          child: Text(
            'Remover',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}
