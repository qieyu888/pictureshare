import 'package:flutter/material.dart';
import '../models/explore_model.dart';
import '../services/mock_data_service.dart';
import '../theme/app_theme.dart';
import 'theme_detail_screen.dart';

class ThemesListScreen extends StatelessWidget {
  const ThemesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themes = MockDataService.getFeaturedThemes();

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          '全部专题',
          style: TextStyle(
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
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 16 / 9,
        ),
        itemCount: themes.length,
        itemBuilder: (context, index) {
          final theme = themes[index];
          return _ThemeCard(
            theme: theme,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ThemeDetailScreen(theme: theme),
              ),
            ),
          );
        },
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
              errorBuilder: (_, __, ___) => Container(color: AppTheme.gray100),
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
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${theme.count} 作品',
                    style: TextStyle(
                      color: AppTheme.white.withValues(alpha: 0.7),
                      fontSize: 9,
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
