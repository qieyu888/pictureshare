import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import '../widgets/settings_tile.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  final StorageService _storage = StorageService();
  bool _profileVisible = true;
  bool _allowMessages = true;
  bool _showActivity = true;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final profileVisible = await _storage.getPrivacyProfileVisible();
    final allowMessages = await _storage.getPrivacyAllowMessages();
    final showActivity = await _storage.getPrivacyShowActivity();
    if (mounted) {
      setState(() {
        _profileVisible = profileVisible;
        _allowMessages = allowMessages;
        _showActivity = showActivity;
        _loading = false;
      });
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
          '隐私设置',
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
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.black, strokeWidth: 2))
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
              children: [
                SettingsSection(
                  title: '可见性',
                  children: [
                    SettingsSwitchTile(
                      icon: Icons.visibility_outlined,
                      title: '公开个人主页',
                      subtitle: '允许其他用户查看你的主页和作品',
                      value: _profileVisible,
                      onChanged: (v) async {
                        setState(() => _profileVisible = v);
                        await _storage.setPrivacyProfileVisible(v);
                      },
                    ),
                    SettingsSwitchTile(
                      icon: Icons.history,
                      title: '展示动态记录',
                      subtitle: '在主页显示点赞和收藏活动',
                      value: _showActivity,
                      onChanged: (v) async {
                        setState(() => _showActivity = v);
                        await _storage.setPrivacyShowActivity(v);
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                SettingsSection(
                  title: '互动',
                  children: [
                    SettingsSwitchTile(
                      icon: Icons.chat_bubble_outline,
                      title: '允许私信',
                      subtitle: '接收其他用户发送的消息',
                      value: _allowMessages,
                      onChanged: (v) async {
                        setState(() => _allowMessages = v);
                        await _storage.setPrivacyAllowMessages(v);
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
                  child: Text(
                    '你可以在「账号与安全 → 隐私政策」中了解更多关于数据使用的信息。',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.gray400,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
