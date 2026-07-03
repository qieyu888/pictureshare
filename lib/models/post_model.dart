class PostModel {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String imageUrl;
  final String caption;
  int likes;
  int inspirations;
  bool isLiked;
  bool isInspired;
  final String timeAgo;
  final List<CommentModel> comments;
  final bool isLocalImage;

  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.inspirations,
    this.isLiked = false,
    this.isInspired = false,
    required this.timeAgo,
    this.comments = const [],
    this.isLocalImage = false,
  });

  PostModel copyWith({
    int? likes,
    int? inspirations,
    bool? isLiked,
    bool? isInspired,
    List<CommentModel>? comments,
    bool? isLocalImage,
  }) {
    return PostModel(
      id: id,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      imageUrl: imageUrl,
      caption: caption,
      likes: likes ?? this.likes,
      inspirations: inspirations ?? this.inspirations,
      isLiked: isLiked ?? this.isLiked,
      isInspired: isInspired ?? this.isInspired,
      timeAgo: timeAgo,
      comments: comments ?? this.comments,
      isLocalImage: isLocalImage ?? this.isLocalImage,
    );
  }
}

class CommentModel {
  final String id;
  final String userName;
  final String content;
  final String timeAgo;

  const CommentModel({
    required this.id,
    required this.userName,
    required this.content,
    required this.timeAgo,
  });
}
