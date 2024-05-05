class RepositoryInfo {
  final int id;
  final String name;
  final String fullName;
  final String? description;
  final String ownerIconPath;
  final String ownerName;
  final String? projectLanguage;
  final int starsCount;
  final int forksCount;
  final int issuesCount;
  final int watchersCount;
  const RepositoryInfo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.ownerIconPath,
    required this.ownerName,
    required this.projectLanguage,
    required this.starsCount,
    required this.forksCount,
    required this.issuesCount,
    required this.watchersCount,
  });

  factory RepositoryInfo.fromJson(Map<String, dynamic> json) {
    return RepositoryInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String?,
      ownerIconPath: json['owner']['avatar_url'] as String,
      ownerName: json['owner']['login'] as String,
      projectLanguage: json['language'] as String?,
      starsCount: json['stargazers_count'] as int,
      forksCount: json['forks_count'] as int,
      issuesCount: json['open_issues_count'] as int,
      watchersCount: json['watchers_count'] as int,
    );
  }
}
