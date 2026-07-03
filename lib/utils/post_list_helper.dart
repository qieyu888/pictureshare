import '../models/post_model.dart';
import '../services/storage_service.dart';

class PostListHelper {
  static final StorageService _storage = StorageService();

  static Future<List<PostModel>> withInteractions(List<PostModel> posts) async {
    final liked = await _storage.getLikedPosts();
    final inspired = await _storage.getInspiredPosts();
    return posts
        .map((post) => post.copyWith(
              isLiked: liked.contains(post.id),
              isInspired: inspired.contains(post.id),
            ))
        .toList();
  }

  static Future<List<PostModel>> toggleLike(List<PostModel> posts, int index) async {
    final post = posts[index];
    await _storage.toggleLikedPost(post.id);
    posts[index] = post.copyWith(
      isLiked: !post.isLiked,
      likes: post.isLiked ? post.likes - 1 : post.likes + 1,
    );
    return List<PostModel>.from(posts);
  }

  static Future<List<PostModel>> toggleInspire(List<PostModel> posts, int index) async {
    final post = posts[index];
    await _storage.toggleInspiredPost(post.id);
    posts[index] = post.copyWith(
      isInspired: !post.isInspired,
      inspirations: post.isInspired ? post.inspirations - 1 : post.inspirations + 1,
    );
    return List<PostModel>.from(posts);
  }
}
