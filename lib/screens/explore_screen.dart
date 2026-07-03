import 'package:flutter/material.dart';
import '../models/explore_model.dart';
import '../services/mock_data_service.dart';
import '../theme/app_theme.dart';
import 'topic_screen.dart';
import 'theme_detail_screen.dart';
import 'category_screen.dart';
import 'themes_list_screen.dart';
import 'search_results_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<TopicModel> _topics = [];
  List<FeaturedThemeModel> _themes = [];
  List<CategoryModel> _categories = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _topics = MockDataService.getTrendingTopics();
    _themes = MockDataService.getFeaturedThemes();
    _categories = MockDataService.getCategories();
    
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    setState(() {
      _isSearching = query.isNotEmpty;
    });
  }

  void _submitSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    _searchFocusNode.unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(query: query),
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    _searchFocusNode.unfocus();
    setState(() {
      _isSearching = false;
    });
  }

  void _showSearchClearButton() {
    setState(() {
      _isSearching = _searchController.text.isNotEmpty;
    });
  }

  void _navigateToTopicPosts(TopicModel topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopicScreen(topic: topic),
      ),
    );
  }

  void _navigateToThemeDetail(FeaturedThemeModel theme) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ThemeDetailScreen(theme: theme),
      ),
    );
  }

  void _navigateToCategoryPosts(CategoryModel category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(category: category),
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
            floating: true,
            backgroundColor: AppTheme.white.withValues(alpha: 0.9),
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.gray100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        decoration: InputDecoration(
                          hintText: '寻找共鸣的瞬间...',
                          hintStyle: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.gray400,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 18,
                            color: AppTheme.gray400,
                          ),
                          suffixIcon: _isSearching
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    size: 18,
                                    color: AppTheme.gray400,
                                  ),
                                  onPressed: _clearSearch,
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        style: const TextStyle(fontSize: 13),
                        onChanged: (_) => _showSearchClearButton(),
                        onSubmitted: (_) => _submitSearch(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.people_outline, color: AppTheme.gray700, size: 24),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: AppTheme.gray100),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                _buildTrendingTopics(),
                const SizedBox(height: 32),
                _buildFeaturedThemes(),
                const SizedBox(height: 32),
                _buildCategories(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingTopics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.local_fire_department, size: 16, color: AppTheme.orange500),
              const SizedBox(width: 6),
              const Text(
                '正在讨论',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.gray900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _topics.map((topic) => _TopicChip(topic: topic, onTap: () => _navigateToTopicPosts(topic))).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedThemes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(Icons.trending_up, size: 16, color: AppTheme.blue500),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  '热门专题',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.gray900,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ThemesListScreen()),
                  );
                },
                child: const Icon(Icons.arrow_forward, size: 16, color: AppTheme.gray300),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 16 / 9,
            ),
            itemCount: _themes.length,
            itemBuilder: (context, index) {
              final theme = _themes[index];
              return _ThemeCard(theme: theme, onTap: () => _navigateToThemeDetail(theme));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '分类探索',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppTheme.gray900,
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return _CategoryCard(category: category, onTap: () => _navigateToCategoryPosts(category));
            },
          ),
        ],
      ),
    );
  }
}

class _TopicChip extends StatelessWidget {
  final TopicModel topic;
  final VoidCallback onTap;

  const _TopicChip({required this.topic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.gray50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.gray100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.chat_bubble_outline, size: 12, color: AppTheme.gray400),
            const SizedBox(width: 6),
            Text(
              topic.name,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.gray700,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${topic.postCount}',
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.gray400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final FeaturedThemeModel theme;
  final VoidCallback onTap;

  const _ThemeCard({required this.theme, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              theme.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: AppTheme.gray100),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    theme.name,
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${theme.count} 作品',
                    style: TextStyle(
                      color: AppTheme.white.withValues(alpha: 0.7),
                      fontSize: 9,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const _CategoryCard({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              category.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: AppTheme.gray100),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.25),
            ),
            Center(
              child: Text(
                category.tag,
                style: const TextStyle(
                  color: AppTheme.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
