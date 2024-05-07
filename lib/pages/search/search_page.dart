import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:yumemi_flutter/components/search_form.dart';
import 'package:yumemi_flutter/models/repository_info.dart';
import 'package:yumemi_flutter/pages/search/search_page_controller.dart';
import 'package:yumemi_flutter/providers/theme_mode_provider.dart';
import '../../components/components.dart';

/// アプリのトップページになるウィジェット
/// リポジトリの検索と検索結果の表示を行う
class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(searchPageController);
    final notifier = ref.watch(searchPageController.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search GitHub Repository'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
            icon: ref.watch(themeModeProvider) == ThemeMode.light
                ? const Icon(Icons.dark_mode_outlined)
                : const Icon(Icons.light_mode),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SearchForm(
              hintText: 'Search github repository',
              controller: notifier.textEditingController,
              onPressed: () async {
                await notifier.startSearching();
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await notifier.startSearching();
              },
              child: PagedListView.separated(
                pagingController: controller.pagingController,
                separatorBuilder: (context, index) => const Divider(height: 1),
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, item, index) {
                    final repositoryInfo = item as RepositoryInfo;
                    return RepositoryInfoTile(
                      imagePath: repositoryInfo.ownerIconPath,
                      name: repositoryInfo.fullName,
                      description: repositoryInfo.description ?? '',
                      onPressed: () {
                        context.push(
                          '/detail',
                          extra: repositoryInfo,
                        );
                        controller.pagingController.value.status;
                      },
                    );
                  },
                  // 初回読み込み時にエラーが発生した場合このbuilderが呼ばれる
                  firstPageErrorIndicatorBuilder: (context) {
                    return _MessageWidget.hasError();
                  },
                  // 2ページ目以降の読み込み時にエラーが発生した場合このbuilderが呼ばれる
                  newPageErrorIndicatorBuilder: (context) {
                    return _MessageWidget.hasError();
                  },
                  // アイテムが1件もない場合このbuilderが呼ばれる
                  noItemsFoundIndicatorBuilder: (context) {
                    return _MessageWidget.noData();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageWidget extends StatelessWidget {
  const _MessageWidget._({
    required this.message,
    required this.icon,
  });

  factory _MessageWidget.noData() {
    return const _MessageWidget._(
      message: 'No data found.\nPlease search other word.',
      icon: Icon(
        Icons.info_outline,
        size: 48,
        color: Colors.green,
      ),
    );
  }

  factory _MessageWidget.hasError() {
    return const _MessageWidget._(
      message: 'An error occurred.\nPlease try again.',
      icon: Icon(
        Icons.error_outline,
        size: 48,
        color: Colors.red,
      ),
    );
  }

  final String message;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 64),
        icon,
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
