import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import '../widgets/settings_tile.dart';
import 'privacy_settings_screen.dart';
import 'notification_settings_screen.dart';
import 'about_screen.dart';
import 'account_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback? onLogout;

  const SettingsScreen({super.key, this.onLogout});

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          '退出使用',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          '退出后将返回欢迎页，您的本地数据不会丢失。',
          style: TextStyle(fontSize: 14, color: AppTheme.gray600, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消', style: TextStyle(color: AppTheme.gray500)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('退出', style: TextStyle(color: AppTheme.red500, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await StorageService().logout();
      if (context.mounted) {
        Navigator.pop(context);
        onLogout?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.gray50,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          '设置',
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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          SettingsSection(
            title: '账号',
            children: [
              SettingsTile(
                icon: Icons.person_outline,
                title: '账号与安全',
                subtitle: '协议、隐私相关',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AccountSettingsScreen()),
                ),
              ),
              SettingsTile(
                icon: Icons.lock_outline,
                title: '隐私设置',
                subtitle: '主页可见性、消息权限',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacySettingsScreen()),
                ),
                showDivider: false,
              ),
            ],
          ),

          SettingsSection(
            title: '通用',
            children: [
              SettingsTile(
                icon: Icons.notifications_outlined,
                title: '通知设置',
                subtitle: '点赞、评论、影展提醒',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationSettingsScreen()),
                ),
              ),
              SettingsTile(
                icon: Icons.storage_outlined,
                title: '存储管理',
                subtitle: '缓存占用 128 MB',
                onTap: () => _showStorageDialog(context),
                showDivider: false,
              ),
            ],
          ),

          SettingsSection(
            title: '关于',
            children: [
              SettingsTile(
                icon: Icons.info_outline,
                title: '关于光影志',
                subtitle: '版本 1.0.0',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                ),
                showDivider: false,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Logout button
          Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.gray100),
            ),
            clipBehavior: Clip.antiAlias,
            child: SettingsTile(
              icon: Icons.logout,
              title: '退出使用',
              onTap: () => _confirmLogout(context),
              showDivider: false,
              trailing: null,
            ),
          ),
        ],
      ),
    );
  }

  void _showStorageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('存储管理', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        content: const Text(
          '当前缓存占用约 128 MB，主要为图片缓存。\n\n清除缓存不会影响您的账号数据和已发布作品。',
          style: TextStyle(fontSize: 14, color: AppTheme.gray600, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消', style: TextStyle(color: AppTheme.gray500)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('缓存已清除'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('清除缓存', style: TextStyle(color: AppTheme.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
