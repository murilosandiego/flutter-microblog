import 'package:boticario_news/ui/helpers/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../main/routes/app_routes.dart';
import '../../components/reload_screen.dart';
import 'components/post_widget.dart';
import 'cubit/feed_cubit.dart';
import 'cubit/feed_state.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FeedCubit>(context);
    cubit.load();

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              child: Consumer<UserManager>(
                builder: (context, user, child) {
                  return UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      child: Text(
                        '${user.username[0]}',
                        style: TextStyle(fontSize: 32),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    accountName: Text(user.username),
                    accountEmail: Text(user.email),
                  );
                },
              ),
            ),
            ListTile(
              title: Text('Sair'),
              onTap: () => cubit.logoutUser(),
              trailing: Icon(Icons.exit_to_app),
            )
          ],
        ),
      ),
      backgroundColor: Color(0xFFF0F2F5),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Feed',
          style: TextStyle(fontSize: 17),
        ),
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
                  context, AppRoutes.welcome, (route) => false);
            }
          },
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
