import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../theme/app_theme.dart';
import '../utils/post_moderation.dart';
import '../utils/share_utils.dart';

class PostDetailScreen extends StatefulWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.white.withValues(alpha: 0.9),
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.chevron_left, size: 28, color: AppTheme.gray900),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'MASTERPIECE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: AppTheme.gray400,
              ),
            ),
            centerTitle: true,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.more_horiz, size: 22, color: AppTheme.gray700),
                onPressed: () => PostModeration.showOptionsSheet(
                  context,
                  post: widget.post,
                  onAction: () => Navigator.pop(context),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.ios_share, size: 20, color: AppTheme.gray700),
                onPressed: () => ShareUtils.showShareSheet(
                  context,
                  title: widget.post.caption.isNotEmpty ? widget.post.caption : '摄影作品',
                  subtitle: widget.post.userName,
                  onShare: () => ShareUtils.sharePost(context, widget.post),
                  postId: widget.post.id,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                SizedBox(
                  height: MediaQuery.of(context).size.width * 1.2,
                  child: Container(
                    color: AppTheme.black,
                    child: widget.post.isLocalImage
                        ? Image.file(
                            File(widget.post.imageUrl),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: AppTheme.gray100,
                              child: const Center(
                                child: Icon(Icons.image_not_supported_outlined,
                                    color: AppTheme.gray300, size: 40),
                              ),
                            ),
                          )
                        : Image.network(
                            widget.post.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
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

                // User info
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          widget.post.userAvatar,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.gray100,
                            ),
                            child: const Icon(Icons.person, color: AppTheme.gray400),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.userName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.gray900,
                              ),
                            ),
                            Text(
                              widget.post.timeAgo.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppTheme.gray400,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Caption
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.gray50,
                    borderRadius: BorderRadius.circular(24),
                    border: const Border(
                      left: BorderSide(color: AppTheme.black, width: 4),
                    ),
                  ),
                  child: Text(
                    '" ${widget.post.caption} "',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.gray700,
                      height: 1.6,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Comments section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.emoji_emotions_outlined,
                              size: 14, color: AppTheme.gray900),
                          const SizedBox(width: 6),
                          Text(
                            '听听共勉者的声音'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.gray400,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Comment input
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: AppTheme.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                'ME',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                hintText: '此时此地，你的共鸣是...',
                                hintStyle: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.gray400,
                                ),
                                filled: true,
                                fillColor: AppTheme.gray100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Existing comments
                      ...widget.post.comments.map((comment) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${comment.userName}: ',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.gray900,
                                          ),
                                        ),
                                        TextSpan(
                                          text: comment.content,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppTheme.gray600,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
