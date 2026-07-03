import 'dart:io';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/post_model.dart';
import '../services/mock_data_service.dart';
import '../services/post_service.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import '../utils/share_utils.dart';
import 'edit_profile_screen.dart';
import 'post_detail_screen.dart';

import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final PostService? postService;
  final VoidCallback? onLogout;

  const ProfileScreen({super.key, this.postService, this.onLogout});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel _user;
  bool _showGrid = true;
  List<PostModel> _userPosts = [];
  List<PostModel> _savedPosts = [];
  final StorageService _storage = StorageService();

  @override
  void initState() {
    super.initState();
    _user = MockDataService.getCurrentUser();
    _loadUserPosts();
    _loadSavedPosts();
    widget.postService?.addListener(_onPostsChanged);
  }

  @override
  void dispose() {
    widget.postService?.removeListener(_onPostsChanged);
    super.dispose();
  }

  void _onPostsChanged() {
    _loadUserPosts();
    _loadSavedPosts();
  }

  void _loadUserPosts() {
    final allPosts = widget.postService?.getAllPosts() ?? [];
    setState(() {
      _userPosts = allPosts.where((post) => post.userId == _user.id).toList();
    });
  }

  Future<void> _loadSavedPosts() async {
    final savedIds = await _storage.getSavedPosts();
    final servicePosts = widget.postService?.getAllPosts() ?? [];
    final map = <String, PostModel>{};
    for (final post in [...servicePosts, ...MockDataService.getAllAvailablePosts()]) {
      map[post.id] = post;
    }
    if (mounted) {
      setState(() {
        _savedPosts = savedIds
            .map((id) => map[id])
            .whereType<PostModel>()
            .toList()
            .reversed
            .toList();
      });
    }
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.white.withValues(alpha: 0.9),
            surfaceTintColor: Colors.transparent,
            pinned: true,
            title: Text(
              _user.userName,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppTheme.gray900,
                letterSpacing: -0.3,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: AppTheme.gray700, size: 22),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettingsScreen(onLogout: widget.onLogout),
                    ),
                  );
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: AppTheme.gray50),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar + stats row
                  Row(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(48),
                            child: Image.network(
                              _user.avatarUrl,
                              width: 88,
                              height: 88,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 88,
                                height: 88,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.gray100,
                                ),
                                child: const Icon(Icons.person, size: 40, color: AppTheme.gray400),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppTheme.black,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppTheme.white, width: 2),
                              ),
                              child: const Icon(Icons.add, size: 14, color: AppTheme.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatItem(
                              value: _user.postsCount.toString(),
                              label: '作品',
                            ),
                            _StatItem(
                              value: _formatCount(_user.followersCount),
                              label: '关注',
                            ),
                            _StatItem(
                              value: _formatCount(_user.inspirationsCount),
                              label: '共勉',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Bio
                  Text(
                    _user.displayName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.gray900,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _user.bio,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.gray600,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProfileScreen(user: _user),
                              ),
                            ).then((updatedUser) {
                              if (updatedUser != null) {
                                setState(() {
                                  _user = updatedUser;
                                });
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: AppTheme.gray900,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                '编辑资料',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => ShareUtils.shareProfile(_user),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: AppTheme.gray100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                '分享主页',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.gray900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tab bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              showGrid: _showGrid,
              onGridTap: () => setState(() => _showGrid = true),
              onSavedTap: () => setState(() => _showGrid = false),
            ),
          ),

          // Grid
          SliverPadding(
            padding: EdgeInsets.zero,
            sliver: _showGrid
                ? (_userPosts.isEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          height: 200,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_library_outlined,
                                  size: 48, color: AppTheme.gray300),
                              const SizedBox(height: 12),
                              Text(
                                '还没有发布作品',
                                style: TextStyle(fontSize: 14, color: AppTheme.gray400),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 1.5,
                          mainAxisSpacing: 1.5,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final post = _userPosts[index];
                            return _GridPostItem(
                              post: post,
                              onTap: () => _openPostDetail(post),
                            );
                          },
                          childCount: _userPosts.length,
                        ),
                      ))
                : (_savedPosts.isEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          height: 200,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bookmark_border,
                                  size: 48, color: AppTheme.gray300),
                              const SizedBox(height: 12),
                              Text(
                                '还没有收藏',
                                style: TextStyle(fontSize: 14, color: AppTheme.gray400),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '在动态中点击分享 → 收藏',
                                style: TextStyle(fontSize: 12, color: AppTheme.gray300),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 1.5,
                          mainAxisSpacing: 1.5,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final post = _savedPosts[index];
                            return _GridPostItem(
                              post: post,
                              onTap: () => _openPostDetail(post),
                            );
                          },
                          childCount: _savedPosts.length,
                        ),
                      )),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.gray900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppTheme.gray400,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final bool showGrid;
  final VoidCallback onGridTap;
  final VoidCallback onSavedTap;

  const _TabBarDelegate({
    required this.showGrid,
    required this.onGridTap,
    required this.onSavedTap,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppTheme.white,
      child: Column(
        children: [
          Container(height: 1, color: AppTheme.gray50),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onGridTap,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.grid_on,
                            size: 22,
                            color: showGrid ? AppTheme.black : AppTheme.gray300,
                          ),
                          const SizedBox(height: 4),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 2,
                            width: showGrid ? 24 : 0,
                            color: AppTheme.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onSavedTap,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark_border,
                            size: 22,
                            color: !showGrid ? AppTheme.black : AppTheme.gray300,
                          ),
                          const SizedBox(height: 4),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 2,
                            width: !showGrid ? 24 : 0,
                            color: AppTheme.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return oldDelegate.showGrid != showGrid;
  }
}

class _GridPostItem extends StatelessWidget {
  final PostModel post;
  final VoidCallback onTap;

  const _GridPostItem({required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          post.isLocalImage
              ? Image.file(
                  File(post.imageUrl),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: AppTheme.gray100),
                )
              : Image.network(
                  post.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: AppTheme.gray100),
                ),
          if (post.inspirations > 0)
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.emoji_events,
                  size: 12,
                  color: AppTheme.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
