import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/post_model.dart';
import 'mock_data_service.dart';

class PostService extends ChangeNotifier {
  static final PostService _instance = PostService._internal();
  factory PostService() => _instance;
  PostService._internal();

  final List<PostModel> _userPosts = [];
  int _postCounter = 100;

  List<PostModel> getAllPosts() {
    final mockPosts = MockDataService.getMockPosts();
    return [..._userPosts, ...mockPosts];
  }

  void addPost({
    File? imageFile,
    String? caption,
    String? imagePath,
  }) {
    _postCounter++;
    
    final user = MockDataService.getCurrentUser();
    final newPost = PostModel(
      id: _postCounter.toString(),
      userId: user.id,
      userName: user.userName,
      userAvatar: user.avatarUrl,
      imageUrl: imageFile?.path ?? imagePath ?? '',
      caption: caption ?? '',
      likes: 0,
      inspirations: 0,
      timeAgo: '刚刚',
      isLocalImage: true,
    );
    
    _userPosts.insert(0, newPost);
    notifyListeners();
  }
}
