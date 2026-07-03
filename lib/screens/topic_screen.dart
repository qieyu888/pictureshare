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
import '../widgets/post_card.dart';

class TopicScreen extends StatefulWidget {
  final TopicModel topic;

  const TopicScreen({super.key, required this.topic});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  List<PostModel> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final posts = MockDataService.getPostsByTopic(widget.topic.id);
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

  void _shareTopic() {
    ShareUtils.showShareSheet(
      context,
      title: widget.topic.name,
      subtitle: '${widget.topic.postCount} 个相关作品',
      onShare: () async {
        await Share.share(
          '${widget.topic.name}\n\n${widget.topic.postCount} 个相关作品\n\n来光影志参与讨论',
        );
      },
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
              widget.topic.name,
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
                icon: const Icon(Icons.ios_share, color: AppTheme.gray700, size: 20),
                onPressed: _shareTopic,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            color: AppTheme.orange500.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.local_fire_department,
                            color: AppTheme.orange500,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '话题讨论',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.gray900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${widget.topic.postCount} 个相关作品',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.gray400,
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
                    '最新动态',
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
                          '暂无相关动态',
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
