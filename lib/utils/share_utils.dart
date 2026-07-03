import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../models/exhibition_model.dart';
import '../services/storage_service.dart';

class ShareUtils {
  static Future<void> sharePost(BuildContext context, PostModel post) async {
    final text = '📸 ${post.userName} 在光影志分享了一张作品\n\n'
        '"${post.caption}"\n\n'
        '❤️ ${post.likes}  🏆 ${post.inspirations}\n\n'
        '来光影志发现更多精彩摄影作品';
    await Share.share(text);
  }

  static Future<void> shareProfile(UserModel user) async {
    final text = '📷 ${user.displayName} (@${user.userName})\n\n'
        '${user.bio}\n\n'
        '📸 ${user.postsCount} 作品 · ❤️ ${user.followersCount} 关注 · 🏆 ${user.inspirationsCount} 共勉\n\n'
        '来光影志看看我的主页';
    await Share.share(text);
  }

  static Future<void> shareExhibition(BuildContext context, ExhibitionModel exhibition) async {
    final desc = exhibition.description.isNotEmpty
        ? '${exhibition.description.substring(0, exhibition.description.length.clamp(0, 80))}...'
        : '';
    final text = '🖼️ ${exhibition.title}\n\n'
        '策展人：${exhibition.curator}\n'
        '${exhibition.participants} 位艺术家参展\n\n'
        '$desc\n\n'
        '来光影志欣赏完整影展';
    await Share.share(text);
  }

  static void showShareSheet(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onShare,
    String? postId,
    VoidCallback? onSaved,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ShareSheet(
        title: title,
        subtitle: subtitle,
        onShare: onShare,
        postId: postId,
        onSaved: onSaved,
      ),
    );
  }
}

class _ShareSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onShare;
  final String? postId;
  final VoidCallback? onSaved;

  const _ShareSheet({
    required this.title,
    required this.subtitle,
    required this.onShare,
    this.postId,
    this.onSaved,
  });

  @override
  State<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<_ShareSheet> {
  bool _isSaved = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedState();
  }

  Future<void> _loadSavedState() async {
    if (widget.postId == null) {
      setState(() => _loading = false);
      return;
    }
    final saved = await StorageService().isPostSaved(widget.postId!);
    if (mounted) {
      setState(() {
        _isSaved = saved;
        _loading = false;
      });
    }
  }

  Future<void> _toggleSave() async {
    if (widget.postId == null) return;
    final nowSaved = await StorageService().toggleSavedPost(widget.postId!);
    if (mounted) {
      setState(() => _isSaved = nowSaved);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(nowSaved ? '已添加到收藏' : '已取消收藏'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      widget.onSaved?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.ios_share, color: Colors.black87),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.subtitle,
                          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 1),
            _ShareOption(
              icon: Icons.share_outlined,
              label: '分享给好友',
              onTap: () {
                Navigator.pop(context);
                widget.onShare();
              },
            ),
            _ShareOption(
              icon: Icons.link_outlined,
              label: '复制链接',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('链接已复制到剪贴板'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            if (widget.postId != null)
              _ShareOption(
                icon: _isSaved ? Icons.bookmark : Icons.bookmark_border_outlined,
                label: _loading ? '收藏' : (_isSaved ? '取消收藏' : '收藏'),
                onTap: _loading ? () {} : _toggleSave,
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87, size: 22),
      title: Text(
        label,
        style: const TextStyle(fontSize: 15, color: Colors.black87),
      ),
      onTap: onTap,
    );
  }
}
