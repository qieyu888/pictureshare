import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/mock_data_service.dart';
import '../theme/app_theme.dart';
import '../utils/post_list_helper.dart';
import '../utils/post_moderation.dart';
import '../widgets/post_card.dart';
import 'post_detail_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  List<PostModel> _posts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    final results = MockDataService.searchPosts(widget.query);
    final filtered = await PostModeration.filterPosts(results);
    final withInteractions = await PostListHelper.withInteractions(filtered);
    if (mounted) {
      setState(() {
        _posts = withInteractions;
        _loading = false;
      });
    }
  }

  Future<void> _toggleLike(int index) async {
    final updated = await PostListHelper.toggleLike(_posts, index);
    setState(() => _posts = updated);
  }

  Future<void> _toggleInspire(int index) async {
    final updated = await PostListHelper.toggleInspire(_posts, index);
    setState(() => _posts = updated);
  }

  void _openPostDetail(PostModel post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PostDetailScreen(post: post)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          '搜索「${widget.query}」',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.gray900,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppTheme.gray100),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.black, strokeWidth: 2))
          : _posts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 48, color: AppTheme.gray300),
                      const SizedBox(height: 12),
                      Text(
                        '未找到相关内容',
                        style: TextStyle(fontSize: 14, color: AppTheme.gray400),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return PostCard(
                      post: post,
                      onLike: () => _toggleLike(index),
                      onInspire: () => _toggleInspire(index),
                      onTap: () => _openPostDetail(post),
                      onModerated: _loadResults,
                    );
                  },
                ),
    );
  }
}
