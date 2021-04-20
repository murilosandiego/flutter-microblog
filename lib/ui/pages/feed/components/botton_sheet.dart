import 'package:boticario_news/main/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../post_viewmodel.dart';
import 'modal_post/modal_post.dart';
import 'modal_remove.dart';

Future getBottomSheet({
  @required BuildContext context,
  @required NewsViewModel news,
}) {
  final cubit = context.read(feedProvider.notifier);

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          children: <Widget>[
            ListTile(
                title: Text(
                  'Editar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () async {
                  final message = await showModalPost(context, news: news);
                  if (message != null)
                    cubit.handleSavePost(message: message, postId: news.id);
                  Navigator.of(context).pop();
                }),
            ListTile(
              title: Text(
                'Remover',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                final postId = await showModalRemove(
                  news: news,
                  context: context,
                );
                if (postId != null) cubit.handleRemovePost(postId: postId);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
