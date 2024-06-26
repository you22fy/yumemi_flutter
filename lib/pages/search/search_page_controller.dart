import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:yumemi_flutter/models/repository_info.dart';
import 'package:yumemi_flutter/repositories/github_repository.dart';

final searchPageController =
    StateNotifierProvider<SearchPageController, SearchPageState>(
  (ref) {
    return SearchPageController(
      GithubRepository(),
    );
  },
);

class SearchPageController extends StateNotifier<SearchPageState> {
  final GithubRepository githubRepository;

  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  SearchPageController(this.githubRepository)
      : super(SearchPageState.initial()) {
    state.pagingController.addPageRequestListener(
      (pageKey) async {
        final repositoriesInfo = await fetchRepositoriesInfo(pageKey);
        final isLastPage = repositoriesInfo.length < 30;
        if (isLastPage) {
          state.pagingController.appendLastPage(repositoriesInfo);
        } else {
          final nextPageKey = pageKey + 1;
          state.pagingController.appendPage(repositoriesInfo, nextPageKey);
        }
      },
    );
  }

  /// 検索を開始する
  Future<void> startSearching() async {
    if (state.pagingController.itemList != null &&
        state.pagingController.itemList!.isNotEmpty) {
      state.pagingController.itemList = [];
    }
    state = state.copyWith(
      query: textEditingController.text,
    );
    if (state.query.isEmpty) {
      return;
    }

    // pageは1スタート
    final data = await fetchRepositoriesInfo(1);
    state.pagingController.appendPage(data, 2);
  }

  Future<List<RepositoryInfo>> fetchRepositoriesInfo(int page) async {
    if (state.query.isEmpty) {
      return [];
    }

    final repositoriesInfo = await githubRepository.fetchRepositoryInfo(
      state.query,
      page: page,
    );
    return repositoriesInfo;
  }
}

class SearchPageState {
  String query;
  PagingController<int, RepositoryInfo> pagingController;
  SearchPageState({
    required this.query,
    required this.pagingController,
  });

  factory SearchPageState.initial() {
    return SearchPageState(
      query: '',
      pagingController: PagingController(firstPageKey: 0),
    );
  }

  SearchPageState copyWith({
    String? query,
    PagingController<int, RepositoryInfo>? pagingController,
  }) {
    return SearchPageState(
      query: query ?? this.query,
      pagingController: pagingController ?? this.pagingController,
    );
  }
}
