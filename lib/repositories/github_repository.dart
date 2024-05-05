import 'dart:io';

import 'package:yumemi_flutter/models/repository_info.dart';
import 'package:yumemi_flutter/repositories/api.dart';

class GithubRepository {
  Future<List<RepositoryInfo>> fetchRepositoryInfo(
    String query, {
    required int page,
  }) async {
    final response = await doGetRequest(
      '/search/repositories?q=$query&page=$page',
      3,
      const Duration(seconds: 30),
    );
    if (response == null) {
      throw const HttpException('Failed to fetch repositories info.');
    }

    final json = response.data as Map<String, dynamic>;
    final items = json['items'] as List<dynamic>;
    return items.map((e) => RepositoryInfo.fromJson(e)).toList();
  }
}
