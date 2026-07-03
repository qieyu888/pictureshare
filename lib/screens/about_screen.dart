import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/settings_tile.dart';
import 'legal_document_screen.dart';
import 'feedback_screen.dart';
import 'open_source_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.gray50,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          '关于光影志',
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
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
        children: [
          // App info header
          Center(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppTheme.black,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 36,
                    color: AppTheme.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '光影志',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.gray900,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '版本 1.0.0',
                  style: TextStyle(fontSize: 13, color: AppTheme.gray400),
                ),
                const SizedBox(height: 8),
                const Text(
                  '记录光影，分享灵感',
                  style: TextStyle(fontSize: 14, color: AppTheme.gray500),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          SettingsSection(
            title: '帮助与支持',
            children: [
              SettingsTile(
                icon: Icons.rate_review_outlined,
                title: '意见反馈',
                subtitle: '告诉我们你的想法和建议',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                ),
              ),
              SettingsTile(
                icon: Icons.help_outline,
                title: '常见问题',
                subtitle: '使用指南与解答',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FaqScreen()),
                ),
                showDivider: false,
              ),
            ],
          ),

          SettingsSection(
            title: '法律信息',
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
              ),
              SettingsTile(
                icon: Icons.code,
                title: '开源许可',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OpenSourceScreen()),
                ),
                showDivider: false,
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Center(
            child: Text(
              '© 2026 光影志 LensMate',
              style: TextStyle(fontSize: 12, color: AppTheme.gray300),
            ),
          ),
        ],
      ),
    );
  }
}

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  static const _faqs = [
    ('如何发布作品？', '点击底部导航栏中间的「+」按钮，选择照片并添加描述即可发布。'),
    ('什么是「共勉」？', '「共勉」是光影志特有的互动方式，表示你从某张作品中获得了拍摄灵感。'),
    ('如何参与影展？', '在「影展」标签页浏览当前进行中的主题影展，点击「参与」即可投稿。'),
    ('如何编辑个人资料？', '进入「我的」页面，点击「编辑资料」按钮即可修改昵称和简介。'),
    ('如何管理隐私？', '在「我的 → 设置 → 隐私设置」中可以控制主页可见性和消息权限。'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          '常见问题',
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
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _faqs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final (question, answer) = _faqs[index];
          return _FaqItem(question: question, answer: answer);
        },
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.gray50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.gray100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.gray900,
                    ),
                  ),
                ),
                Icon(
                  _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 20,
                  color: AppTheme.gray400,
                ),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: 10),
              Text(
                widget.answer,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.gray600,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
