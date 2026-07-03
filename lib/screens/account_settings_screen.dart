import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/settings_tile.dart';
import 'legal_document_screen.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.gray50,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          '账号与安全',
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
            title: '协议与政策',
            children: [
              SettingsTile(
                icon: Icons.description_outlined,
                title: '用户协议',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LegalDocumentScreen(
                      type: LegalDocumentType.userAgreement,
                    ),
                  ),
                ),
              ),
              SettingsTile(
                icon: Icons.shield_outlined,
                title: '隐私政策',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LegalDocumentScreen(
                      type: LegalDocumentType.privacyPolicy,
                    ),
                  ),
                ),
                showDivider: false,
              ),
            ],
          ),

          SettingsSection(
            title: '数据',
            children: [
              SettingsTile(
                icon: Icons.download_outlined,
                title: '导出我的数据',
                subtitle: '下载您在应用中的个人数据副本',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('数据导出请求已提交，完成后将通知您'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              SettingsTile(
                icon: Icons.delete_outline,
                title: '清除本地数据',
                subtitle: '清除点赞、收藏等本地记录',
                onTap: () => _confirmClearData(context),
                showDivider: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmClearData(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('清除本地数据', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        content: const Text(
          '将清除本设备的点赞、收藏等本地记录，此操作不可撤销。',
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
                  content: Text('本地数据已清除'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('确认清除', style: TextStyle(color: AppTheme.red500, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
