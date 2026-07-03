import 'package:flutter/material.dart';
import '../models/explore_model.dart';
import '../models/post_model.dart';
import '../services/mock_data_service.dart';
import '../theme/app_theme.dart';
import '../utils/post_list_helper.dart';
import '../utils/post_moderation.dart';
import 'post_detail_screen.dart';
import '../widgets/post_card.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<PostModel> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final posts = MockDataService.getPostsByCategory(widget.category.id);
    final filtered = await PostModeration.filterPosts(posts);
    final withInteractions = await PostListHelper.withInteractions(filtered);
    if (mounted) setState(() => _posts = withInteractions);
  }

  Future<void> _toggleLike(int index) async {
    final updated = await PostListHelper.toggleLike(_posts, index);
    setState(() => _posts = updated);
  }

  Future<void> _toggleInspire(int index) async {
    final updated = await PostListHelper.toggleInspire(_posts, index);
    setState(() => _posts = updated);
  }

  void _navigateToPostDetail(PostModel post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PostDetailScreen(post: post)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppTheme.white.withValues(alpha: 0.9),
            surfaceTintColor: Colors.transparent,
            title: Text(
              widget.category.tag,
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.category.imageUrl,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 160,
                        color: AppTheme.gray100,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.gray50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.blue500.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.category,
                            color: AppTheme.blue500,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.category.tag,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.gray900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.category.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.gray500,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '相关作品',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.gray900,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: _posts.isEmpty
                ? SliverChildListDelegate([
                    SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          '暂无相关作品',
                          style: TextStyle(fontSize: 14, color: AppTheme.gray400),
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
                        onInspire: () => _toggleInspire(index),
                        onTap: () => _navigateToPostDetail(post),
                        onModerated: _loadPosts,
                      );
                    },
                    childCount: _posts.length,
                  ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
