import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/explore_model.dart';
import '../models/post_model.dart';
import '../services/mock_data_service.dart';
import '../theme/app_theme.dart';
import '../utils/post_list_helper.dart';
import '../utils/post_moderation.dart';
import '../utils/share_utils.dart';
import 'post_detail_screen.dart';

class ThemeDetailScreen extends StatefulWidget {
  final FeaturedThemeModel theme;

  const ThemeDetailScreen({super.key, required this.theme});

  @override
  State<ThemeDetailScreen> createState() => _ThemeDetailScreenState();
}

class _ThemeDetailScreenState extends State<ThemeDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _worksKey = GlobalKey();
  List<PostModel> _posts = [];
  bool _followed = false;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadPosts() async {
    final posts = MockDataService.getPostsByTheme(widget.theme.id);
    final filtered = await PostModeration.filterPosts(posts);
    final withInteractions = await PostListHelper.withInteractions(filtered);
    if (mounted) setState(() => _posts = withInteractions);
  }

  Future<void> _toggleLike(int index) async {
    final updated = await PostListHelper.toggleLike(_posts, index);
    setState(() => _posts = updated);
  }

  void _navigateToPostDetail(PostModel post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PostDetailScreen(post: post)),
    );
  }

  void _scrollToWorks() {
    final context = _worksKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _toggleFollow() {
    setState(() => _followed = !_followed);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_followed ? '已关注专题「${widget.theme.name}」' : '已取消关注'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareTheme() {
    ShareUtils.showShareSheet(
      context,
      title: widget.theme.name,
      subtitle: '${widget.theme.count} 作品',
      onShare: () async {
        await Share.share(
          '🎨 专题：${widget.theme.name}\n\n${widget.theme.count} 位摄影师的作品\n\n来光影志欣赏完整专题',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppTheme.white.withValues(alpha: 0.9),
            surfaceTintColor: Colors.transparent,
            title: Text(
              widget.theme.name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppTheme.gray900,
              ),
            ),
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.chevron_left, color: AppTheme.gray900),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _followed ? Icons.favorite : Icons.favorite_border,
                  color: _followed ? AppTheme.red500 : AppTheme.gray700,
                  size: 22,
                ),
                onPressed: _toggleFollow,
              ),
              IconButton(
                icon: const Icon(Icons.ios_share, color: AppTheme.gray700, size: 20),
                onPressed: _shareTheme,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.theme.imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppTheme.gray100,
                            height: 200,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.theme.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gray900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.theme.count} 位摄影师的作品',
                        style: const TextStyle(fontSize: 13, color: AppTheme.gray400),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.black,
                            foregroundColor: AppTheme.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _scrollToWorks,
                          child: const Text(
                            '查看作品',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  key: _worksKey,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    children: [
                      Icon(Icons.grid_view, color: AppTheme.gray900, size: 18),
                      SizedBox(width: 6),
                      Text(
                        '精选作品',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gray900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          _posts.isEmpty
              ? SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        '暂无作品',
                        style: TextStyle(fontSize: 14, color: AppTheme.gray400),
                      ),
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      final post = _posts[index];
                      return GestureDetector(
                        onTap: () => _navigateToPostDetail(post),
                        onLongPress: () {
                          _toggleLike(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(post.isLiked ? '已点赞' : '已取消点赞'),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                post.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Container(color: AppTheme.gray100),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.6),
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        post.isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 12,
                                        color: post.isLiked
                                            ? AppTheme.red500
                                            : AppTheme.white,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${post.likes}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppTheme.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
