import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OpenSourceScreen extends StatelessWidget {
  const OpenSourceScreen({super.key});

  static const _licenses = [
    ('Flutter SDK', 'BSD 3-Clause License', 'Google LLC'),
    ('shared_preferences', 'BSD 3-Clause License', 'The Flutter Authors'),
    ('image_picker', 'Apache License 2.0', 'The Flutter Authors'),
    ('share_plus', 'BSD 3-Clause License', 'Flutter Community'),
    ('intl', 'BSD 3-Clause License', 'Dart Project Authors'),
    ('cupertino_icons', 'MIT License', 'Apple Inc.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          '开源许可',
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _licenses.length,
        separatorBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(height: 1, color: AppTheme.gray50),
        ),
        itemBuilder: (context, index) {
          final (name, license, author) = _licenses[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            title: Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.gray900,
              ),
            ),
            subtitle: Text(
              '$license · $author',
              style: const TextStyle(fontSize: 12, color: AppTheme.gray400),
            ),
            trailing: const Icon(Icons.chevron_right, size: 20, color: AppTheme.gray300),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: AppTheme.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  content: Text(
                    '本项目使用了 $name，遵循 $license。\n\n版权所有 © $author',
                    style: const TextStyle(fontSize: 13, color: AppTheme.gray600, height: 1.5),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('关闭', style: TextStyle(color: AppTheme.black, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
