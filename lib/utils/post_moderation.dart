import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';

class PostModeration {
  static final StorageService _storage = StorageService();

  static Future<List<PostModel>> filterPosts(List<PostModel> posts) async {
    final blockedUsers = await _storage.getBlockedUsers();
    final shieldedPosts = await _storage.getShieldedPosts();
    return posts
        .where((post) =>
            !blockedUsers.contains(post.userId) &&
            !shieldedPosts.contains(post.id))
        .toList();
  }

  static void showOptionsSheet(
    BuildContext context, {
    required PostModel post,
    VoidCallback? onAction,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.gray200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              _OptionTile(
                icon: Icons.flag_outlined,
                title: '举报',
                subtitle: '举报不当内容',
                isDestructive: true,
                onTap: () {
                  Navigator.pop(ctx);
                  _showReportDialog(context, post: post, onAction: onAction);
                },
              ),
              _OptionTile(
                icon: Icons.block,
                title: '拉黑',
                subtitle: '不再看到该用户的任何内容',
                isDestructive: true,
                onTap: () {
                  Navigator.pop(ctx);
                  _showBlockDialog(context, post: post, onAction: onAction);
                },
              ),
              _OptionTile(
                icon: Icons.visibility_off_outlined,
                title: '屏蔽',
                subtitle: '隐藏此条动态',
                isDestructive: true,
                onTap: () {
                  Navigator.pop(ctx);
                  _showShieldDialog(context, post: post, onAction: onAction);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  static void _showReportDialog(
    BuildContext context, {
    required PostModel post,
    VoidCallback? onAction,
  }) {
    const reasons = ['垃圾信息', '不当内容', '侵犯版权', '虚假信息', '其他原因'];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          '举报内容',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: reasons
              .map((reason) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(reason, style: const TextStyle(fontSize: 15)),
                    onTap: () async {
                      Navigator.pop(ctx);
                      await _storage.reportPost(post.id);
                      await _storage.shieldPost(post.id);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('举报已提交，我们会尽快处理'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        onAction?.call();
                      }
                    },
                  ))
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消', style: TextStyle(color: AppTheme.gray500)),
          ),
        ],
      ),
    );
  }

  static void _showBlockDialog(
    BuildContext context, {
    required PostModel post,
    VoidCallback? onAction,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          '拉黑用户',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        content: Text(
          '确定要拉黑 ${post.userName} 吗？拉黑后将不再看到该用户的任何内容。',
          style: const TextStyle(fontSize: 14, color: AppTheme.gray600, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消', style: TextStyle(color: AppTheme.gray500)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _storage.blockUser(post.userId);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('已拉黑 ${post.userName}'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                onAction?.call();
              }
            },
            child: const Text(
              '确定拉黑',
              style: TextStyle(color: AppTheme.red500, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  static void _showShieldDialog(
    BuildContext context, {
    required PostModel post,
    VoidCallback? onAction,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          '屏蔽动态',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          '屏蔽后将不再显示此条动态。',
          style: TextStyle(fontSize: 14, color: AppTheme.gray600, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消', style: TextStyle(color: AppTheme.gray500)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _storage.shieldPost(post.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('已屏蔽此动态'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                onAction?.call();
              }
            },
            child: const Text(
              '确定屏蔽',
              style: TextStyle(color: AppTheme.red500, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _OptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppTheme.red500 : AppTheme.gray700;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: color),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: AppTheme.gray400),
      ),
      onTap: onTap,
    );
  }
}
