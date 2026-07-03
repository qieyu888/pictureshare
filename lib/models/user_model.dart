class UserModel {
  final String id;
  final String userName;
  final String displayName;
  final String avatarUrl;
  final String bio;
  final int postsCount;
  final int followersCount;
  final int inspirationsCount;

  const UserModel({
    required this.id,
    required this.userName,
    required this.displayName,
    required this.avatarUrl,
    required this.bio,
    required this.postsCount,
    required this.followersCount,
    required this.inspirationsCount,
  });
}
