class TopicModel {
  final String id;
  final String name;
  final int postCount;

  const TopicModel({
    required this.id,
    required this.name,
    required this.postCount,
  });
}

class FeaturedThemeModel {
  final String id;
  final String name;
  final String imageUrl;
  final String count;

  const FeaturedThemeModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.count,
  });
}

class CategoryModel {
  final String id;
  final String tag;
  final String imageUrl;
  final String description;

  const CategoryModel({
    required this.id,
    required this.tag,
    required this.imageUrl,
    required this.description,
  });
}
