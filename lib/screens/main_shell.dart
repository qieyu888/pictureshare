import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/post_service.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'exhibition_screen.dart';
import 'profile_screen.dart';
import 'create_post_screen.dart';

class MainShell extends StatefulWidget {
  final VoidCallback? onLogout;

  const MainShell({super.key, this.onLogout});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  final PostService _postService = PostService();

  @override
  void initState() {
    super.initState();
  }

  void _openCreatePost() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => const CreatePostScreen(),
      ),
    );

    if (result != null && mounted) {
      _postService.addPost(
        imageFile: result['image'],
        caption: result['caption'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(postService: _postService),
          const ExploreScreen(),
          const ExhibitionScreen(),
          ProfileScreen(postService: _postService, onLogout: widget.onLogout),
        ],
      ),
      bottomNavigationBar: _BottomNavBar(
        currentIndex: _currentIndex,
        onTabChanged: (index) => setState(() => _currentIndex = index),
        onCreateTap: _openCreatePost,
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  final VoidCallback onCreateTap;

  const _BottomNavBar({
    required this.currentIndex,
    required this.onTabChanged,
    required this.onCreateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        border: const Border(
          top: BorderSide(color: AppTheme.gray100, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.favorite_border,
                activeIcon: Icons.favorite,
                label: '灵感',
                isActive: currentIndex == 0,
                onTap: () => onTabChanged(0),
              ),
              _NavItem(
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
                label: '发现',
                isActive: currentIndex == 1,
                onTap: () => onTabChanged(1),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onCreateTap,
                  child: Center(
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppTheme.black,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppTheme.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              _NavItem(
                icon: Icons.photo_library_outlined,
                activeIcon: Icons.photo_library,
                label: '影展',
                isActive: currentIndex == 2,
                onTap: () => onTabChanged(2),
              ),
              _NavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: '我的',
                isActive: currentIndex == 3,
                onTap: () => onTabChanged(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, isActive ? -2 : 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                size: 24,
                color: isActive ? AppTheme.black : AppTheme.gray300,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isActive ? AppTheme.black : AppTheme.gray300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
