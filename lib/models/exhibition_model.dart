class ExhibitionModel {
  final String id;
  final String title;
  final String coverUrl;
  final String curator;
  final int participants;
  final bool isOngoing;
  final String description;
  final List<String> tags;
  final List<ExhibitionWorkModel> works;

  const ExhibitionModel({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.curator,
    required this.participants,
    this.isOngoing = true,
    this.description = '',
    this.tags = const [],
    this.works = const [],
  });
}

class ExhibitionWorkModel {
  final String id;
  final String imageUrl;
  final String authorName;
  final String authorAvatar;
  final String title;
  final int likes;

  const ExhibitionWorkModel({
    required this.id,
    required this.imageUrl,
    required this.authorName,
    required this.authorAvatar,
    required this.title,
    required this.likes,
  });
}

class ChallengeModel {
  final String id;
  final String title;
  final String description;
  final int daysLeft;

  const ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.daysLeft,
  });
}
