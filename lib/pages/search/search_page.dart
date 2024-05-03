import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// アプリのトップページになるウィジェット
/// リポジトリの検索と検索結果の表示を行う
class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Search Page'),
          ),
          TextButton(
            onPressed: () => context.push('/detail'),
            child: const Text('Go to Detail Page'),
          )
        ],
      ),
    );
  }
}
