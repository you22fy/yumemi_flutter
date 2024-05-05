import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yumemi_flutter/models/repository_info.dart';
import 'package:yumemi_flutter/pages/detail/detail_page.dart';
import 'package:yumemi_flutter/pages/search/search_page.dart';

final goRouter = GoRouter(
  initialLocation: '/search',
  routes: [
    GoRoute(
      path: '/search',
      name: 'search',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const SearchPage(),
        );
      },
    ),
    GoRoute(
      path: '/detail',
      name: 'detail',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: DetailPage(
            repositoryInfo: state.extra! as RepositoryInfo,
          ),
        );
      },
    ),
  ],
  // 遷移ページがないなどのエラーが発生した時に、このページに行く
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
