import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import '../widgets/settings_tile.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  final StorageService _storage = StorageService();
  bool _notifyLikes = true;
  bool _notifyComments = true;
  bool _notifyFollows = true;
  bool _notifyExhibitions = true;
  bool _notifySystem = true;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final likes = await _storage.getNotifyLikes();
    final comments = await _storage.getNotifyComments();
    final follows = await _storage.getNotifyFollows();
    final exhibitions = await _storage.getNotifyExhibitions();
    final system = await _storage.getNotifySystem();
    if (mounted) {
      setState(() {
        _notifyLikes = likes;
        _notifyComments = comments;
        _notifyFollows = follows;
        _notifyExhibitions = exhibitions;
        _notifySystem = system;
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
          '通知设置',
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
                  title: '互动通知',
                  children: [
                    SettingsSwitchTile(
                      icon: Icons.favorite_border,
                      title: '点赞提醒',
                      subtitle: '有人为你的作品点赞时通知',
                      value: _notifyLikes,
                      onChanged: (v) async {
                        setState(() => _notifyLikes = v);
                        await _storage.setNotifyLikes(v);
                      },
                    ),
                    SettingsSwitchTile(
                      icon: Icons.chat_outlined,
                      title: '评论提醒',
                      subtitle: '有人评论你的作品时通知',
                      value: _notifyComments,
                      onChanged: (v) async {
                        setState(() => _notifyComments = v);
                        await _storage.setNotifyComments(v);
                      },
                    ),
                    SettingsSwitchTile(
                      icon: Icons.person_add_outlined,
                      title: '关注提醒',
                      subtitle: '有新用户关注你时通知',
                      value: _notifyFollows,
                      onChanged: (v) async {
                        setState(() => _notifyFollows = v);
                        await _storage.setNotifyFollows(v);
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                SettingsSection(
                  title: '活动通知',
                  children: [
                    SettingsSwitchTile(
                      icon: Icons.photo_library_outlined,
                      title: '影展提醒',
                      subtitle: '参与的影展有新动态时通知',
                      value: _notifyExhibitions,
                      onChanged: (v) async {
                        setState(() => _notifyExhibitions = v);
                        await _storage.setNotifyExhibitions(v);
                      },
                    ),
                    SettingsSwitchTile(
                      icon: Icons.campaign_outlined,
                      title: '系统通知',
                      subtitle: '版本更新、活动公告等',
                      value: _notifySystem,
                      onChanged: (v) async {
                        setState(() => _notifySystem = v);
                        await _storage.setNotifySystem(v);
                      },
                      showDivider: false,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
