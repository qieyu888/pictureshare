import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/storage_service.dart';
import '../services/post_service.dart';
import '../theme/app_theme.dart';
import '../widgets/post_card.dart';
import '../utils/post_moderation.dart';
import 'post_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final PostService postService;
  const HomeScreen({super.key, required this.postService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> _posts = [];
  final StorageService _storageService = StorageService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
    widget.postService.addListener(_onPostsChanged);
  }

  @override
  void dispose() {
    widget.postService.removeListener(_onPostsChanged);
    super.dispose();
  }

  void _onPostsChanged() {
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final posts = widget.postService.getAllPosts();
    final likedPosts = await _storageService.getLikedPosts();
    final inspiredPosts = await _storageService.getInspiredPosts();
    final filtered = await PostModeration.filterPosts(posts);

    setState(() {
      _posts = filtered.map((post) {
        return post.copyWith(
          isLiked: likedPosts.contains(post.id),
          isInspired: inspiredPosts.contains(post.id),
        );
      }).toList();
      _isLoading = false;
    });
  }

  Future<void> _toggleLike(int index) async {
    final post = _posts[index];
    await _storageService.toggleLikedPost(post.id);
    setState(() {
      _posts[index] = post.copyWith(
        isLiked: !post.isLiked,
        likes: post.isLiked ? post.likes - 1 : post.likes + 1,
      );
    });
  }

  Future<void> _toggleInspiration(int index) async {
    final post = _posts[index];
    await _storageService.toggleInspiredPost(post.id);
    setState(() {
      _posts[index] = post.copyWith(
        isInspired: !post.isInspired,
        inspirations: post.isInspired ? post.inspirations - 1 : post.inspirations + 1,
      );
    });
  }

  void _openPostDetail(PostModel post) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PostDetailScreen(post: post),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.black))
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  backgroundColor: AppTheme.white.withValues(alpha: 0.9),
                  surfaceTintColor: Colors.transparent,
                  title: const Text(
                    'LensMate',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: AppTheme.gray900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined, color: AppTheme.gray700),
                      onPressed: () {},
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(1),
                    child: Container(
                      height: 1,
                      color: AppTheme.gray100,
                    ),
                  ),
                ),
                SliverList(
                  delegate: _posts.isEmpty
                      ? SliverChildListDelegate([
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.visibility_off_outlined,
                                      size: 48, color: AppTheme.gray300),
                                  const SizedBox(height: 12),
                                  Text(
                                    '暂无动态',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.gray400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])
                      : SliverChildBuilderDelegate(
                          (context, index) {
                            final post = _posts[index];
                            return PostCard(
                              post: post,
                              onLike: () => _toggleLike(index),
                              onInspire: () => _toggleInspiration(index),
                              onTap: () => _openPostDetail(post),
                              onModerated: _loadPosts,
                            );
                          },
                          childCount: _posts.length,
                        ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),
    );
  }
}
