import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../theme/app_theme.dart';
import '../utils/post_moderation.dart';
import '../utils/share_utils.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onLike;
  final VoidCallback onInspire;
  final VoidCallback onTap;
  final VoidCallback? onModerated;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onInspire,
    required this.onTap,
    this.onModerated,
  });

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  void _showMoreOptions(BuildContext context) {
    PostModeration.showOptionsSheet(
      context,
      post: post,
      onAction: onModerated,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    post.userAvatar,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.gray100,
                      ),
                      child: const Icon(Icons.person, size: 18, color: AppTheme.gray400),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    post.userName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.gray900,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showMoreOptions(context),
                  child: const Icon(Icons.more_horiz, color: AppTheme.gray300, size: 20),
                ),
              ],
            ),
          ),

          // Image
          GestureDetector(
            onTap: onTap,
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: post.isLocalImage
                  ? Image.file(
                      File(post.imageUrl),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppTheme.gray100,
                        child: const Center(
                          child: Icon(Icons.image_not_supported_outlined,
                              color: AppTheme.gray300, size: 40),
                        ),
                      ),
                    )
                  : Image.network(
                      post.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppTheme.gray50,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.gray300,
                              strokeWidth: 1.5,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppTheme.gray100,
                        child: const Center(
                          child: Icon(Icons.image_not_supported_outlined,
                              color: AppTheme.gray300, size: 40),
                        ),
                      ),
                    ),
            ),
          ),

          // Actions and caption
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _ActionButton(
                      icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                      count: _formatCount(post.likes),
                      color: post.isLiked ? AppTheme.red500 : AppTheme.gray700,
                      onTap: onLike,
                    ),
                    const SizedBox(width: 20),
                    _ActionButton(
                      icon: post.isInspired
                          ? Icons.emoji_events
                          : Icons.emoji_events_outlined,
                      count: _formatCount(post.inspirations),
                      color: post.isInspired ? AppTheme.yellow500 : AppTheme.gray700,
                      onTap: onInspire,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => ShareUtils.showShareSheet(
                        context,
                        title: post.caption.isNotEmpty ? post.caption : '摄影作品',
                        subtitle: post.userName,
                        onShare: () => ShareUtils.sharePost(context, post),
                        postId: post.id,
                        onSaved: onModerated,
                      ),
                      child: const Icon(
                        Icons.ios_share,
                        size: 20,
                        color: AppTheme.gray700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${post.userName} ',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gray900,
                        ),
                      ),
                      TextSpan(
                        text: post.caption,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.gray800,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  post.timeAgo.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.gray400,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: AppTheme.gray50),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String count;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.count,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(width: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppTheme.gray400,
            ),
          ),
        ],
      ),
    );
  }
}
