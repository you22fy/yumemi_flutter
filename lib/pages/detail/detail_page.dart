import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_flutter/models/repository_info.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(repositoryInfo.fullName),
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
              Text(
                repositoryInfo.projectLanguage!,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _DisplayNumberWithIcon(
                  iconData: Icons.star,
                  iconColor: Colors.amber,
                  number: repositoryInfo.starsCount,
                  title: 'Star',
                ),
                const SizedBox(height: 4),
                _DisplayNumberWithIcon(
                  iconData: Icons.remove_red_eye,
                  iconColor: Colors.blue,
                  number: repositoryInfo.watchersCount,
                  title: 'Watcher',
                ),
                const SizedBox(height: 4),
                _DisplayNumberWithIcon(
                  iconData: Icons.call_split,
                  iconColor: Colors.green,
                  number: repositoryInfo.forksCount,
                  title: 'Fork',
                ),
                const SizedBox(height: 4),
                _DisplayNumberWithIcon(
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

class _DisplayNumberWithIcon extends StatelessWidget {
  const _DisplayNumberWithIcon({
    required this.iconData,
    required this.iconColor,
    required this.number,
    required this.title,
  });

  final IconData iconData;
  final Color iconColor;
  final int number;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 48,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          number.toString(),
          style: const TextStyle(fontSize: 21),
        ),
      ],
    );
  }
}
