import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_flutter/components/components.dart';
import 'package:yumemi_flutter/models/repository_info.dart';
import 'package:yumemi_flutter/providers/localize_provider.dart';
import 'package:yumemi_flutter/providers/theme_mode_provider.dart';
import 'package:github_language_colors/github_language_colors.dart';

/// 各リポジトリの詳細情報を表示するページ
/// リポジトリ名、オーナーアイコン、プロジェクト言語、Star数、Watcher数、Fork数、Issue数を表示する
///
/// このページ・Controllerでは取得処理は行わず、引数で渡された[RepositoryInfo]型のデータを表示するだけ
class DetailPage extends ConsumerWidget {
  const DetailPage({
    required this.repositoryInfo,
    super.key,
  });

  final RepositoryInfo repositoryInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langColorCode =
        githubLanguageColors[repositoryInfo.projectLanguage ?? ''];
    final langColor =
        langColorCode != null ? Color(langColorCode) : Colors.grey;

    return Scaffold(
      appBar: AppBar(
        title: Text(repositoryInfo.fullName),
        // FIXME: search_pageにも同様の実装があるので要共通化.
        actions: [
          // HACK: ２言語である前提の実装なのでリファクタした方が良い
          IconButton(
            onPressed: () {
              ref.read(languageProvider.notifier).setLanguage(
                    ref.watch(languageProvider) == const Locale('en')
                        ? Language.ja
                        : Language.en,
                  );
              final message = ref.read(languageProvider) == const Locale('en')
                  ? '言語設定を日本語にを変更しました'
                  : 'Changed language setting to English';
              showMessageDialog(context: context, text: message);
            },
            icon: const Icon(
              Icons.language,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(languageProvider.notifier).setLanguage(
                    ref.watch(languageProvider) == const Locale('en')
                        ? Language.ja
                        : Language.en,
                  );
            },
            icon: const Icon(
              Icons.language,
            ),
          ),
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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(repositoryInfo.ownerIconPath),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    50.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              repositoryInfo.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (repositoryInfo.projectLanguage != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: langColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    repositoryInfo.projectLanguage!,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DisplayNumberWithIcon(
                  iconData: Icons.star,
                  iconColor: Colors.amber,
                  number: repositoryInfo.starsCount,
                  title: 'Star',
                ),
                DisplayNumberWithIcon(
                  iconData: Icons.remove_red_eye,
                  iconColor: Colors.blue,
                  number: repositoryInfo.watchersCount,
                  title: 'Watcher',
                ),
                DisplayNumberWithIcon(
                  iconData: Icons.call_split,
                  iconColor: Colors.green,
                  number: repositoryInfo.forksCount,
                  title: 'Fork',
                ),
                DisplayNumberWithIcon(
                  iconData: Icons.bug_report,
                  iconColor: Colors.red,
                  number: repositoryInfo.issuesCount,
                  title: 'Issue',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
