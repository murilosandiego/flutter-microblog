import 'package:boticario_news/ui/helpers/user_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../post_viewmodel.dart';
import 'botton_sheet.dart';

class PostWidget extends StatelessWidget {
  final NewsViewModel news;

  const PostWidget({@required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(
            news: news,
          ),
          SizedBox(height: 10),
          Text('${news.message}')
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final NewsViewModel news;

  const _Header({
    @required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          child: Icon(Icons.person),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${news.user}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${news.date}',
                  style: TextStyle(color: Theme.of(context).dividerColor),
                )
              ],
            ),
          ),
        ),
        if (news.id != null && news.userId == context.read<UserManager>().id)
          Container(
            height: 25,
            width: 25,
            // ignore: deprecated_member_use
            child: FlatButton(
              textColor: Colors.black54,
              padding: EdgeInsets.zero,
              onPressed: () => getBottomSheet(context: context, news: news),
              child: Icon(Icons.more_vert),
            ),
          )
      ],
    );
  }
}
