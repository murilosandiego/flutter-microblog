import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/pages/app_pages.dart';
import '../../components/reload_screen.dart';
import 'components/post_widget.dart';
import 'cubit/feed_cubit.dart';
import 'cubit/feed_state.dart';

class FeedPageCubit extends StatefulWidget {
  @override
  _FeedPageCubitState createState() => _FeedPageCubitState();
}

class _FeedPageCubitState extends State<FeedPageCubit> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FeedCubit>(context);
    cubit.load();
    return Scaffold(
      backgroundColor: Color(0xFFF0F2F5),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Feed',
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => cubit.logoutUser(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.post_add),
      ),
      body: RefreshIndicator(
        child: BlocConsumer<FeedCubit, FeedState>(
          listener: (_, state) {
            if (state is LogoutUser) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppPages.welcome, (route) => false);
            }
          },
          cubit: cubit,
          builder: (context, state) {
            if (state is FeedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FeedError) {
              return ReloadScreen(
                error: state.message,
                reload: cubit.load,
              );
            }

            if (state is FeedLoaded) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: state.news.length,
                itemBuilder: (_, index) {
                  final news = state.news[index];
                  return PostWidget(news: news);
                },
              );
            }

            return SizedBox();
          },
        ),
        onRefresh: () => cubit.load(),
      ),
    );
  }
}
