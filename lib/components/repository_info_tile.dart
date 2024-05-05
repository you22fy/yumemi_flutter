import 'package:flutter/material.dart';

class RepositoryInfoTile extends StatelessWidget {
  /// リポジトリ検索結果画面に表示するリポジトリ情報を表示するタイル
  ///
  /// [imagePath] 画像のURL.円形に切り取られ、背景が投下されている場合は[Colors.white]で表示される.
  ///
  /// [name] リポジトリ名として表示される.
  ///
  /// [description] リポジトリの説明文として表示される.
  ///
  /// [onPressed] タップ時のコールバック関数.指定されていない場合は右端に矢印アイコンが表示されない.

  const RepositoryInfoTile({
    required this.imagePath,
    required this.name,
    required this.description,
    this.onPressed,
    super.key,
  });

  final String imagePath;
  final String name;
  final String description;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imagePath),
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (onPressed != null)
              const Icon(
                Icons.chevron_right,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}
